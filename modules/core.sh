#!/usr/bin/env bash

install_core_packages() {
    local GPU="$1"
    CORE_PACKAGES=(hyprland waybar walker xorg xorg-xrandr xorg-xinput base-devel git vim)

    case "$GPU" in
        nvidia) GPU_PKGS=(nvidia nvidia-utils nvidia-settings vulkan) ;;
        amd) GPU_PKGS=(mesa vulkan-radeon) ;;
        intel) GPU_PKGS=(mesa vulkan-intel) ;;
        *) GPU_PKGS=() ;;
    esac

    gum spin --title "Installing core packages..." -- \
        sudo pacman -Syu --noconfirm \
        && sudo pacman -S --needed --noconfirm "${CORE_PACKAGES[@]}" "${GPU_PKGS[@]}"
}
