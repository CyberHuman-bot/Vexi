#!/usr/bin/env bash

apply_dotfiles() {
    gum spin --title "Applying dotfiles and themes..." -- \
        git clone https://github.com/CyberHuman-bot/Vilo-dotfiles.git "$HOME/.vilo-dotfiles" \
        && cp -r "$HOME/.vilo-dotfiles/." "$HOME/" \
        && git clone https://github.com/adi1090x/termux-ohmyzsh.git "$HOME/.vilo-themes"
}
