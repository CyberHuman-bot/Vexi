#!/usr/bin/env bash

install_ractor() {
    RACTOR_URL="https://raw.githubusercontent.com/CyberHuman-bot/Vilo/main/ractor.sh"
    RACTOR_PATH="$HOME/.local/bin/ractor"

    gum spin --title "Downloading Ractor script..." -- \
        mkdir -p "$(dirname "$RACTOR_PATH")" \
        && curl -fsSL "$RACTOR_URL" -o "$RACTOR_PATH" \
        && chmod +x "$RACTOR_PATH"
}
