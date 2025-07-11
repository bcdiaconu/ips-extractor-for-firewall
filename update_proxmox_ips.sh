#!/bin/sh

# List of domains to interrogate
DOMAINS="
cdn.proxmox.com
download.proxmox.com
enterprise.proxmox.com
forum.proxmox.com
git.proxmox.com
pve.proxmox.com
repo.proxmox.com
bugzilla.proxmox.com
updates.proxmox.com
wiki.proxmox.com
www.proxmox.com
releases.turnkeylinux.org
mirror.turnkeylinux.org
www.turnkeylinux.org
api.community-scripts.org
community-scripts.github.io
helper-scripts.com
github.com
raw.githubusercontent.com
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/proxmox-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
