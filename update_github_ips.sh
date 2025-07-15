#!/bin/sh

# Output location
OUTPUT="/var/www/localhost/htdocs/github-ips.txt"
TEMP_DIR="/tmp/github_ips"

# Create temporary directory
mkdir -p "$TEMP_DIR"

# Extract all IPs and networks from GitHub API
echo "Extracting IPs from GitHub API..."
curl -s https://api.github.com/meta | \
    jq -r '.web[], .api[], .git[], .hooks[], .pages[], .importer[], .actions[], .dependabot[], .packages[], .codespaces[], .copilot[], .actions_macos[], .github_enterprise_importer[]' | \
    sort -u > "$TEMP_DIR/api_ips.txt"

# Manual list of additional networks
echo "Adding manual GitHub networks..."
NETWORKS="140.82.121.0/24"
echo "$NETWORKS" | tr ' ' '\n' > "$TEMP_DIR/manual_networks.txt"

# GitHub domains to resolve via DNS
echo "Extracting IPs from GitHub domains via DNS..."
DOMAINS="
github.com
www.github.com
api.github.com
codeload.github.com
github-releases.githubusercontent.com
raw.githubusercontent.com
objects.githubusercontent.com
pkg-containers.githubusercontent.com
avatars0.githubusercontent.com
avatars1.githubusercontent.com
avatars2.githubusercontent.com
avatars3.githubusercontent.com
avatars.githubusercontent.com
central.github.com
cloud.githubusercontent.com
gist.github.com
help.github.com
nodeload.github.com
status.github.com
training.github.com
assets-cdn.github.com
documentcloud.github.com
pages.github.com
raw.github.com
ghcr.io
npm.pkg.github.com
maven.pkg.github.com
nuget.pkg.github.com
rubygems.pkg.github.com
docker.pkg.github.com
"

# Use the create_ips_list.sh script to resolve domains
./create_ips_list.sh "$DOMAINS" "$TEMP_DIR/dns_ips.txt"

# Combine both sources and remove duplicates
echo "Combining API and DNS results..."
cat "$TEMP_DIR/api_ips.txt" "$TEMP_DIR/dns_ips.txt" "$TEMP_DIR/manual_networks.txt" 2>/dev/null | \
    grep -v '^$' | \
    sort -u > "$OUTPUT"

# Cleanup
rm -rf "$TEMP_DIR"

echo "GitHub IPs and networks saved to: $OUTPUT"
echo "Total unique entries: $(wc -l < "$OUTPUT")"
