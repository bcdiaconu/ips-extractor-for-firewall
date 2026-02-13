#!/bin/sh

# List of domains to interrogate
DOMAINS="
nvidia.com
www.nvidia.com
developer.nvidia.com
download.nvidia.com
us.download.nvidia.com
eu.download.nvidia.com
asia.download.nvidia.com
workbench.download.nvidia.com
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/nvidia-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
