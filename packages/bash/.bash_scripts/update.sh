full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade -y
    sudo apt autoremove

    # nvm
    nvm install node --reinstall-packages-from=node

    # # snap
    # sudo snap refresh

    # # sdkman
    # sdk selfupdate
    # sdk update
}