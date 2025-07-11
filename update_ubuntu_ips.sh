#!/bin/sh

# List of domains to interrogate
DOMAINS="
archive.ubuntu.com
security.ubuntu.com
api.snapcraft.io
snapcraft.io
livepatch.canonical.com
motd.ubuntu.com
changelogs.ubuntu.com
ntp.ubuntu.com
releases.ubuntu.com
packages.ubuntu.com
launchpad.net
keyserver.ubuntu.com
ppa.launchpad.net
bazaar.launchpad.net
code.launchpad.net
bugs.launchpad.net
answers.launchpad.net
translations.launchpad.net
people.canonical.com
assets.ubuntu.com
ubuntu.com
canonical.com
cloud-images.ubuntu.com
cdimage.ubuntu.com
old-releases.ubuntu.com
ports.ubuntu.com
partner.archive.canonical.com
extras.ubuntu.com
backports.ubuntu.com
proposed.archive.ubuntu.com
landscape.canonical.com
usn.ubuntu.com
wiki.ubuntu.com
help.ubuntu.com
certification.ubuntu.com
maas.ubuntu.com
juju.ubuntu.com
snapstore.io
login.ubuntu.com
one.ubuntu.com
design.ubuntu.com
insights.ubuntu.com
blog.ubuntu.com
discourse.ubuntu.com
askubuntu.com
ubuntuforums.org
"

# Save IPs to output file
OUTPUT="/var/www/localhost/htdocs/ubuntu-ips.txt"

# Run the extraction script
/usr/local/bin/update-domains-ips-lists/create_ips_list.sh "$DOMAINS" "$OUTPUT"
