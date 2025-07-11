# IPs Extractor for Firewalls

This repository provides shell scripts for extracting and maintaining up-to-date lists of IP addresses for key infrastructure domains used by Proxmox VE, TurnKey Linux, and related community projects.

## Purpose

- **Security & Firewalls:** Generate accurate IP lists for whitelisting or monitoring in firewalls, proxies, or security appliances.
- **pfSense Integration:** Output files are formatted for direct use as pfSense Alias IPs via the URL Table feature, enabling automated firewall rule updates.
- **Automation:** Automate the process of resolving and updating IPs for official repositories, mirrors, and APIs.
- **Auditing:** Help system administrators and DevOps teams track infrastructure endpoints and changes over time.

## How It Works

- Each script defines a list of official domains for a specific ecosystem (e.g., Proxmox, Debian, GitLab).
- The script calls a helper (`create_ips_list.sh`) to resolve all domains and output their current IP addresses to a text file.
- Output files are suitable for direct use in firewall rules, monitoring systems, or documentation.

## Example: Proxmox Script

- `update_proxmox_ips.sh` resolves all official Proxmox, TurnKey Linux, and community-scripts domains.
- Output is saved to `/var/www/localhost/htdocs/proxmox-ips.txt` and can be referenced as a pfSense URL Table Alias.

## Usage

1. Edit the `DOMAINS` list in the script as needed.
1. Validate the output file in `OUTPUT` variable.
1. Run the script with appropriate permissions.
1. Use the generated IP list for your security or monitoring needs, or configure pfSense to fetch the file as a URL Table Alias.

## Supported Ecosystems

- Proxmox VE (official repos, mirrors, forum, bug tracker, etc.)
- TurnKey Linux (official mirrors and downloads)
- Community Scripts (helper-scripts.com, GitHub, API endpoints)

## Requirements

- Bash/sh compatible shell
- Standard Linux utilities (nslookup, dig, etc.)

## License

MIT License

## Disclaimer

This repository is not affiliated with Proxmox Server Solutions GmbH, TurnKey Linux, the Community Scripts project or ANY other project that list is extracted from. All domain lists are based on public documentation and may require periodic updates.
