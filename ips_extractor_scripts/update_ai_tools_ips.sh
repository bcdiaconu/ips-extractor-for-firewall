#!/bin/sh

# List of domains to interrogate
DOMAINS="
downloads.cursor.com
download.docker.com
packagecloud.io
dl.google.com
deb.nodesource.com
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/ai-tools-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
