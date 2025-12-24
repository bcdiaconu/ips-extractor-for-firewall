#!/bin/sh

# List of domains to interrogate
DOMAINS="
filelist.io
reactor.filelist.io
reactor.thefl.org
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/torrent-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
