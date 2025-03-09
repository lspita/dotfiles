__list-packages() {
    apt-mark showmanual
}

__upgrade-packages() {
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove -y
}

__install-packages() {
    xargs -I {} sudo apt install -y {}
}

__uninstall-packages() {
    xargs -I {} sudo apt purge -y {}
}
