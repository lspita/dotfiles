__list-packages() {
    apt-mark showmanual
}

__upgrade-packages() {
    sudo apt update
    sudo apt full-upgrade
    sudo apt autoremove
}

__install-packages() {
    xargs -I {} sudo apt install {}
}

__uninstall-packages() {
    xargs -I {} sudo apt purge {}
}
