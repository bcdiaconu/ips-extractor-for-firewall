#!/bin/sh

# List of domains to interrogate
DOMAINS="
deb.debian.org
security.debian.org
ftp.debian.org
cdn-fastly.deb.debian.org
deb.torproject.org
httpredir.debian.org
packages.debian.org
snapshot.debian.org
tracker.debian.org
keyring.debian.org
pgp.mit.edu
sks-keyservers.net
bugs.debian.org
ci.debian.net
incoming.debian.org
buildd.debian.org
ftp-master.debian.org
api.ftp-master.debian.org
sources.debian.org
cdimage.debian.org
wiki.debian.org
lists.debian.org
salsa.debian.org
qa.debian.org
udd.debian.org
codesearch.debian.net
manpages.debian.org
mentors.debian.net
screenshots.debian.net
piuparts.debian.org
popcon.debian.org
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/debian-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
