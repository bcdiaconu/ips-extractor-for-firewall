#!/bin/sh

# List of domains to interrogate
DOMAINS="
gitlab.com
registry.gitlab.com
packages.gitlab.com
docs.gitlab.com
about.gitlab.com
s3.gitlab.com
uploads.gitlab.com
customers.gitlab.com
support.gitlab.com
status.gitlab.com
version.gitlab.com
id.gitlab.com
forum.gitlab.com
security.gitlab.com
design.gitlab.com
ops.gitlab.net
cdn.registry.gitlab-static.net
gitlab-static.net
gitlab.io
gitlab.net
mg.gitlab.com
incoming.gitlab.com
altssh.gitlab.com
gdk.gitlab.org
releases.gitlab.com
learn.gitlab.com
university.gitlab.com
page.gitlab.io
assets.gitlab.com
gitlab.engineering
handbook.gitlab.com
contributors.gitlab.com
gitlab.company
go.gitlab.com
shop.gitlab.com
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/gitlabs-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
