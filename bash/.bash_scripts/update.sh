full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade
    sudo dnf autoremove

    # snap
    sudo snap refresh
}

system-upgrade() {
    message="Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"

    if [[ ${#} > 0 ]]; then
        message="${1}"
    fi
    
    full-upgrade
    full-freeze

    git -C "${DOTFILES_PATH}" add "${DOTFILES_PATH}"
    git -C "${DOTFILES_PATH}" status
    git -C "${DOTFILES_PATH}" commit -m "${message}"
    git -C  "${DOTFILES_PATH}" push
}