list-packages() {
    apt-mark showmanual
}

upgrade-packages() {
    sudo apt update
    sudo apt full-upgrade
    sudo apt autoremove
}

install-packages() {
    xargs -I {} sudo apt install {}
}

uninstall-packages() {
    xargs -I {} sudo apt purge {}
}
