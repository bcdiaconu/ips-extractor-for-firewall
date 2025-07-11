#!/bin/sh

# Output location
OUTPUT="/var/www/localhost/htdocs/github-ips.txt"

# Extract all IPs and networks from GitHub API - all available fields
curl -s https://api.github.com/meta | \
    jq -r '.web[], .api[], .git[], .hooks[], .pages[], .importer[], .actions[], .dependabot[], .packages[], .codespaces[], .copilot[], .actions_macos[], .github_enterprise_importer[]' | \
    sort -u > "$OUTPUT"

echo "GitHub IPs and networks saved to: $OUTPUT"
