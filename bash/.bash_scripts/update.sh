full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade
    sudo apt autoremove

    # snap
    sudo snap refresh
}

system-upgrade() {
    full-upgrade

    local commit_message="Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"
    if [[ ${#} > 0 ]]; then
        commit_message="${1}"
    fi    

    git -C "${DOTFILES_PATH}" add "${DOTFILES_PATH}"
    git -C "${DOTFILES_PATH}" status
    git -C "${DOTFILES_PATH}" commit -m "${commit_message}"
    git -C  "${DOTFILES_PATH}" push
}