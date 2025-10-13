#!/bin/sh

# List of domains to interrogate
DOMAINS="
a6.tuyaeu.com
h6-eu.iot-dns.com
m6.tuyaeu.com
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/rowenta-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
