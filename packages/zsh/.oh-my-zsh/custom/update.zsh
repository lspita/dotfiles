DUMP_ROOT="$DOTFILES_ROOT/dumps"
BREW_DUMP="$DUMP_ROOT/brew.dump"

full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade -y
    sudo apt autoremove

    # homebrew
    brew update
    brew upgrade
}

full-freeze() {
    # homebrew
    brew leaves -r > $BREW_DUMP
}

full-restore() {
    # homebrew
    xargs brew reinstall < $BREW_DUMP
}


system-upgrade() {
    message=${1:-"Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"}
    
    full-upgrade
    full-freeze

    git -C "${DOTFILES_ROOT}" add "${DOTFILES_ROOT}"
    git -C "${DOTFILES_ROOT}" status
    git -C "${DOTFILES_ROOT}" commit -m "${message}"
    git -C "${DOTFILES_ROOT}" push
}
