#!/usr/bin/env bash

enable_services() {
    gum spin --title "Enabling system services..." -- \
        sudo systemctl enable NetworkManager --now \
        && sudo systemctl enable pipewire --now
}
