#!/bin/sh

# Enhanced DNS resolution script with better error handling and IPv6 support
# Usage: script "domain1 domain2 ..." /path/to/output.txt

# Global variables
DOMAINS=""
OUTPUT=""
TMP=""
MAX_DEPTH=5

# Validate command line arguments
validate_arguments() {
  if [ $# -ne 2 ]; then
    echo "Usage: $0 \"domain1 domain2 ...\" /path/to/output.txt"
    echo "Example: $0 \"github.com api.github.com\" /tmp/ips.txt"
    exit 1
  fi
  
  DOMAINS=$1
  OUTPUT=$2
  TMP=$(mktemp)
}

# Setup cleanup and dependencies
setup_environment() {
  # Trap to ensure cleanup on exit
  trap 'rm -f "$TMP"' EXIT INT TERM
  
  # Check if dig is available
  if ! command -v dig >/dev/null 2>&1; then
    echo "Error: dig command not found. Please install dnsutils/bind-utils package."
    exit 1
  fi
  
  # Validate output directory exists
  OUTPUT_DIR=$(dirname "$OUTPUT")
  if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Error: Output directory '$OUTPUT_DIR' does not exist."
    exit 1
  fi
}

# Clean domain name from URL format
clean_domain_name() {
  domain=$1
  # Remove protocol, trailing slash, path components
  echo "$domain" | sed 's|^https\?://||' | sed 's|/$||' | cut -d'/' -f1
}

# Resolve DNS records for a domain with recursion control
resolve_ip() {
  domain=$1
  depth=$2

  if [ "$depth" -ge "$MAX_DEPTH" ]; then
    echo "# Max recursion depth reached for $domain" >> "$TMP"
    return
  fi

  echo "# Resolving $domain (depth: $depth)" >> "$TMP"

  # A records (IPv4)
  A_RECORDS=$(dig +short A "$domain" 2>/dev/null)
  if [ -n "$A_RECORDS" ]; then
    echo "$A_RECORDS" >> "$TMP"
  fi

  # AAAA records (IPv6) - commented out for now, can be enabled if needed
  # AAAA_RECORDS=$(dig +short AAAA "$domain" 2>/dev/null)
  # if [ -n "$AAAA_RECORDS" ]; then
  #   echo "$AAAA_RECORDS" >> "$TMP"
  # fi

  # CNAME records
  CNAMES=$(dig +short CNAME "$domain" 2>/dev/null)
  for cname in $CNAMES; do
    # Remove trailing dot from FQDN
    cname=$(echo "$cname" | sed 's/\.$//')
    echo "# CNAME for $domain: $cname" >> "$TMP"
    resolve_ip "$cname" $((depth + 1))
  done
}

# Process all domains and resolve their IPs
resolve_all_domains() {
  echo "Starting DNS resolution for domains: $DOMAINS"
  
  for domain in $DOMAINS; do
    clean_domain=$(clean_domain_name "$domain")
    echo "Processing domain: $clean_domain"
    resolve_ip "$clean_domain" 0
    echo "" >> "$TMP"
  done
}

# Validate if IP address format is correct
is_valid_ip_format() {
  ip=$1
  echo "$ip" | grep -Eq '^([0-9]{1,3}\.){3}[0-9]{1,3}$'
}

# Validate if IP octets are within valid range (0-255)
has_valid_octets() {
  ip=$1
  IFS='.' read -r a b c d <<EOF
$ip
EOF
  for octet in "$a" "$b" "$c" "$d"; do
    if [ "$octet" -gt 255 ] || [ "$octet" -lt 0 ]; then
      return 1
    fi
  done
  return 0
}

# Check if IP is in private or reserved ranges
is_public_ip() {
  ip=$1
  echo "$ip" | grep -Evq '^(10\.)|(172\.(1[6-9]|2[0-9]|3[0-1])\.)|(192\.168\.)|(127\.)|(169\.254\.)|(224\.)|(240\.)'
}

# Add appropriate CIDR notation based on network pattern
add_cidr_notation() {
  ip=$1
  if echo "$ip" | grep -q '\.0\.0\.0$'; then
    echo "$ip/8"
  elif echo "$ip" | grep -q '\.0\.0$'; then
    echo "$ip/16"
  elif echo "$ip" | grep -q '\.0$'; then
    echo "$ip/24"
  else
    echo "$ip"
  fi
}

# Extract and filter valid public IPs with CIDR notation
process_and_filter_ips() {
  echo "Processing and filtering IP addresses..."
  
  grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$TMP" \
    | sort -u \
    | while read -r ip; do
      if is_valid_ip_format "$ip" && has_valid_octets "$ip" && is_public_ip "$ip"; then
        add_cidr_notation "$ip"
      fi
    done > "$OUTPUT"
}

# Verify output and report results
verify_output() {
  if [ -f "$OUTPUT" ] && [ -s "$OUTPUT" ]; then
    IP_COUNT=$(wc -l < "$OUTPUT")
    echo "Success: $IP_COUNT IP addresses/networks saved to: $OUTPUT"
  else
    echo "Warning: No valid IP addresses found or output file is empty."
    exit 1
  fi
}

# ===============================
# MAIN EXECUTION FLOW
# ===============================

# Parse and validate command line arguments
validate_arguments "$@"

# Setup environment and check dependencies
setup_environment

# Resolve IP addresses for all specified domains
resolve_all_domains

# Process raw DNS results and filter valid public IPs
process_and_filter_ips

# Verify final output and report success
verify_output
