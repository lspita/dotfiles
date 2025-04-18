__list-requirements() {
    echo apt
}

__list-packages() {
    apt-mark showmanual
}

__upgrade() {
    sudo apt update
    sudo apt full-upgrade -y
}

__clean() {
    sudo apt autoremove -y
}

__install-packages() {
    xargs -I {} sudo apt install -y {}
}

__uninstall-packages() {
    xargs -I {} sudo apt purge -y {}
}
