__require() {
    __command-exists apt
}

__init() {
    # aptitude for apt-mark command
    if ! __command-exists apt-mark; then
        __h3 "aptitude"
        echo "Installing dependency aptitude"
        sudo apt install aptitude
    fi

}

__dump-packages() {
    apt-mark showmanual
}

__upgrade() {
    sudo apt update
    sudo apt full-upgrade -y
}

__clean() {
    sudo apt autoremove -y
}

__install() {
    xargs -I {} sudo apt install -y {}
}

__uninstall() {
    xargs -I {} sudo apt purge -y {}
}
