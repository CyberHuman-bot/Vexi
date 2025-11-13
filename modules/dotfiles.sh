#!/usr/bin/env bash

apply_dotfiles() {
    gum spin --title "Applying Vilo dotfiles and Powerlevel10k theme..." -- \
        git clone https://github.com/CyberHuman-bot/Vilo-dotfiles.git "$HOME/.vilo-dotfiles" \
        && cp -r "$HOME/.vilo-dotfiles/." "$HOME/" \
        && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
        && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" \
        && sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc" \
        && echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> "$HOME/.zshrc" \
        && echo "source ~/.zshrc" > "$HOME/.profile"
}
