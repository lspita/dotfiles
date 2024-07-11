full-upgrade() {
    yay-upgrade
    flatpak-upgrade
}

full-freeze() {
    yay-freeze
    flatpak-freeze
    extensions-freeze
    dconf-freeze
}

full-restore() {
    yay-restore
    flatpak-restore
    extensions-restore
    dconf-restore
}


full-backup() {
    message="Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"

    if [[ $# > 0 ]]; then
        message="$1"
    fi
    
    full-upgrade
    full-freeze

    git -C "$DOTFILES_PATH" commit -am "$message"
    git -C  "$DOTFILES_PATH" push
}