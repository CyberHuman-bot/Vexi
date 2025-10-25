#!/bin/bash

ansi_art='
██╗   ██╗██╗██╗      ██████╗ 
██║   ██║██║██║     ██╔═══██╗
██║   ██║██║██║     ██║   ██║
╚██╗ ██╔╝██║██║     ██║   ██║
 ╚████╔╝ ██║███████╗╚██████╔╝
  ╚═══╝  ╚═╝╚══════╝ ╚═════╝ 
                                 
⚡ Powered by Ractor Package Manager
React Apps at Lightning Speed
'

clear
echo -e "\n$ansi_art\n"

pacman-key --init
pacman -Syu --noconfirm --needed sudo
sudo pacman -Syu --noconfirm --needed wget
sudo pacman -Syu --noconfirm --needed git
sudo pacman -Syu --noconfirm --needed node
sudo pacman -Syu --noconfirm --needed npm
sudo pacman -Syu --noconfirm --needed jq
# Install ractor package manager
wget https://raw.githubusercontent.com/CyberHuman-bot/Ractor/refs/heads/main/ractor.sh
chmod +x ractor.sh
sudo mv ractor.sh /usr/local/bin/ractor

# Use custom repo if specified, otherwise default to CyberHuman-bot/Vilo
VILO_REPO="${VILO_REPO:-CyberHuman-bot/Vilo}"

echo -e "\n⚡ Cloning Vilo from: https://github.com/${VILO_REPO}.git"
rm -rf ~/.local/share/vilo/
git clone "https://github.com/${VILO_REPO}.git" ~/.local/share/vilo >/dev/null

# Use custom branch if instructed, otherwise default to master
VILO_REF="${VILO_REF:-master}"
if [[ $VILO_REF != "master" ]]; then
  echo -e "\e[32m⚡ Using branch: $VILO_REF\e[0m"
  cd ~/.local/share/vilo
  git fetch origin "${VILO_REF}" && git checkout "${VILO_REF}"
  cd -
fi

echo -e "\n⚡ Installation starting..."
source ~/.local/share/vilo/install.sh
