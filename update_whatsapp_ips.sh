#!/bin/sh

# List of domains to interrogate
DOMAINS="
chat.whatsapp.com
web.whatsapp.com
whatsapp.net
cdn.whatsapp.net
graph.whatsapp.net
mmx-ds.cdn.whatsapp.net
static.whatsapp.net
g.whatsapp.net
graph.facebook.com
graph.whatsapp.com
media.fna.whatsapp.net
media-amt2-1.fna.whatsapp.net
media-frt3-2.fna.whatsapp.net
mmg.whatsapp.net
pps.whatsapp.net
v.whatsapp.net
www.whatsapp.com
crashlogs.whatsapp.net
scontent.whatsapp.net
lookaside.whatsapp.net
whatsapp.biz
docker.whatsapp.biz
registration.whatsapp.com
api.whatsapp.com
business.whatsapp.com
faq.whatsapp.com
developers.whatsapp.com
status.whatsapp.com
blog.whatsapp.com
download.whatsapp.com
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/whatsapp-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
