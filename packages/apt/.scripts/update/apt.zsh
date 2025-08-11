__require() {
    __command-exists apt
}

__upgrade() {
    sudo apt update
    sudo apt full-upgrade -y
}

__clean() {
    sudo apt autoremove -y
}
