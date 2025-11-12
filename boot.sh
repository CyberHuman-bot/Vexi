#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# TEMP DIR
# -----------------------------
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# -----------------------------
# COLORS
# -----------------------------
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# -----------------------------
# OS DETECTION
# -----------------------------
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    OS=$ID
else
    OS="unknown"
fi

# -----------------------------
# CHECK DEPENDENCIES
# -----------------------------
deps=(gum curl git)
for d in "${deps[@]}"; do
    if ! command -v "$d" &>/dev/null; then
        echo -e "${YELLOW}Installing missing dependency: $d${NC}"
        case "$OS" in
            arch|manjaro) sudo pacman -S --noconfirm "$d" ;;
            ubuntu|debian) sudo apt install -y "$d" ;;
            *) echo "Please install $d manually"; exit 1 ;;
        esac
    fi
done

# -----------------------------
# WELCOME SCREEN
# -----------------------------
gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 \
    "Welcome to Vilo Installer"

# -----------------------------
# USERNAME
# -----------------------------
USER_NAME=$(gum input --placeholder "Enter your username")
echo -e "${GREEN}Hello, $USER_NAME${NC}"
sleep 1; clear

# -----------------------------
# GPU DETECTION
# -----------------------------
GPU="unknown"
if lspci | grep -iq nvidia; then GPU="nvidia"
elif lspci | grep -iq amd; then GPU="amd"
elif lspci | grep -iq intel; then GPU="intel"
fi
echo -e "${GREEN}Detected GPU: $GPU${NC}"
sleep 1

# -----------------------------
# INSTALL TYPE
# -----------------------------
INSTALL_TYPE=$(gum choose "Full Desktop" "Minimal Desktop" "Exit")
[[ "$INSTALL_TYPE" == "Exit" ]] && echo "Exiting installer." && exit 0

# -----------------------------
# RUN MODULES
# -----------------------------
source ./modules/core.sh
install_core_packages "$GPU"

if [[ "$INSTALL_TYPE" == "Full Desktop" ]]; then
    source ./modules/extras.sh
    install_extras
fi

source ./modules/ractor.sh
install_ractor

source ./modules/dotfiles.sh
apply_dotfiles

source ./modules/services.sh
enable_services

# -----------------------------
# FINISH
# -----------------------------
gum style --border normal --margin "1" --padding "1 2" --border-foreground 57 \
    "Vilo installation complete! Reboot recommended."

gum confirm "Reboot now?" && sudo reboot
