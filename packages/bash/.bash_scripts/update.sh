full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade
    sudo apt autoremove

    # snap
    sudo snap refresh
}