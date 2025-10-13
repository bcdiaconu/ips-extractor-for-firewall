#!/bin/sh

# Installation script for IPs Extractor
# Creates symbolic links for all .sh files into /usr/local/bin/update-domains-ips-lists

# Target directory for symbolic links
TARGET_DIR="/usr/local/bin/update-domains-ips-lists"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source directory for IP scripts
IP_SCRIPTS_DIR="$SCRIPT_DIR/ips_extractor_scripts"

echo "Installing IPs Extractor scripts..."
echo "Source directory: $IP_SCRIPTS_DIR"
echo "Target directory: $TARGET_DIR"

# Check if ips_extractor_scripts directory exists
if [ ! -d "$IP_SCRIPTS_DIR" ]; then
    echo "Error: ips_extractor_scripts directory not found at $IP_SCRIPTS_DIR"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating target directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR" || {
        echo "Error: Failed to create directory $TARGET_DIR"
        echo "You may need to run this script with sudo"
        exit 1
    }
fi

# Create symbolic links for all .sh files in ips_extractor_scripts directory
echo ""
echo "Creating symbolic links..."
for script in "$IP_SCRIPTS_DIR"/*.sh; do
    # Check if any .sh files exist
    if [ ! -e "$script" ]; then
        echo "No .sh files found in $IP_SCRIPTS_DIR"
        exit 1
    fi
    
    # Get the base name of the script
    script_name=$(basename "$script")
    target_link="$TARGET_DIR/$script_name"
    
    # Remove existing link if it exists
    if [ -L "$target_link" ]; then
        echo "  Removing existing link: $script_name"
        rm "$target_link"
    elif [ -e "$target_link" ]; then
        echo "  Warning: $target_link exists but is not a symbolic link"
        echo "  Skipping $script_name"
        continue
    fi
    
    # Create symbolic link
    echo "  Linking: $script_name"
    ln -s "$script" "$target_link" || {
        echo "  Error: Failed to create link for $script_name"
    }
done

echo ""
echo "Installation complete!"
echo ""
echo "Scripts are now available in: $TARGET_DIR"
echo ""
echo "You can run the update scripts from anywhere, for example:"
echo "  $TARGET_DIR/update_debian_ips.sh"
echo "  $TARGET_DIR/update_github_ips.sh"
echo "  $TARGET_DIR/update_proxmox_ips.sh"
echo ""
