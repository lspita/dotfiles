full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade -y
    sudo apt autoremove

    # snap
    sudo snap refresh
}