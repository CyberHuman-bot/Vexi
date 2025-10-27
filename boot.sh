#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ANSI art banner
ansi_art='
██╗   ██╗██╗██╗      ██████╗ 
██║   ██║██║██║     ██╔═══██╗
██║   ██║██║██║     ██║   ██║
╚██╗ ██╔╝██║██║     ██║   ██║
 ╚████╔╝ ██║███████╗╚██████╔╝
  ╚═══╝  ╚═╝╚══════╝ ╚═════╝ 
                                 
Powered by Ractor Package Manager
React Apps at Lightning Speed
'

# Error handler
error_exit() {
    echo -e "${RED}✗ Error: $1${NC}" >&2
    exit 1
}

# Success message
success_msg() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Info message
info_msg() {
    echo -e "${BLUE}→ $1${NC}"
}

# Warning message
warn_msg() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    error_exit "This script only works on Arch Linux or Arch-based distributions"
fi

# Check if pacman is available
if ! command -v pacman &> /dev/null; then
    error_exit "pacman package manager not found. This script requires Arch Linux"
fi

# Check if running as root (we shouldn't be)
if [[ $EUID -eq 0 ]]; then
   error_exit "This script should not be run as root. Please run as a normal user."
fi

# Display banner
clear
echo -e "\n$ansi_art\n"

# Initialize pacman keyring
info_msg "Initializing pacman keyring..."
sudo pacman-key --init || error_exit "Failed to initialize pacman keyring"
success_msg "Keyring initialized"

# Update system and install dependencies
info_msg "Updating system and installing dependencies..."
PACKAGES=(sudo wget git nodejs npm jq)

for pkg in "${PACKAGES[@]}"; do
    info_msg "Installing $pkg..."
    sudo pacman -Syu --noconfirm --needed "$pkg" || error_exit "Failed to install $pkg"
done
success_msg "All dependencies installed"

# Install Ractor package manager
info_msg "Installing Ractor package manager..."
RACTOR_URL="https://raw.githubusercontent.com/CyberHuman-bot/Ractor/refs/heads/main/ractor.sh"

if wget -q --spider "$RACTOR_URL"; then
    wget -O /tmp/ractor.sh "$RACTOR_URL" || error_exit "Failed to download Ractor"
    chmod +x /tmp/ractor.sh
    sudo mv /tmp/ractor.sh /usr/local/bin/ractor || error_exit "Failed to install Ractor"
    success_msg "Ractor installed successfully"
else
    error_exit "Ractor download URL is not accessible"
fi

# Configure Vilo repository
VILO_REPO="${VILO_REPO:-CyberHuman-bot/Vilo}"
VILO_REF="${VILO_REF:-master}"
VILO_DIR="$HOME/.local/share/vilo"

info_msg "Cloning Vilo from: https://github.com/${VILO_REPO}.git"

# Remove old installation if exists
if [[ -d "$VILO_DIR" ]]; then
    warn_msg "Removing existing Vilo installation..."
    rm -rf "$VILO_DIR"
fi

# Clone repository
git clone --quiet "https://github.com/${VILO_REPO}.git" "$VILO_DIR" || error_exit "Failed to clone Vilo repository"
success_msg "Repository cloned successfully"

# Checkout specific branch if specified
if [[ "$VILO_REF" != "master" ]]; then
    info_msg "Switching to branch: $VILO_REF"
    cd "$VILO_DIR" || error_exit "Failed to enter Vilo directory"
    git fetch origin "$VILO_REF" && git checkout "$VILO_REF" || error_exit "Failed to checkout branch $VILO_REF"
    cd - > /dev/null
    success_msg "Branch switched to $VILO_REF"
fi

# Run installation script
info_msg "Running Vilo installation..."
if [[ -f "$VILO_DIR/install.sh" ]]; then
    source "$VILO_DIR/install.sh" || error_exit "Installation script failed"
    success_msg "Vilo installation completed successfully!"
else
    error_exit "Installation script not found at $VILO_DIR/install.sh"
fi

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation Complete! 🎉${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
