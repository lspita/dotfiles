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
