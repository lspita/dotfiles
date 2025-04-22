__check-requirements() {
    __command-exists apt
}

__init() {
    # docker repo
    # https://docs.docker.com/engine/install/debian/#install-using-the-repository
    if ! __command-exists docker; then
        __h3 "docker"
        echo "Uninstallling docker potential conflicts"
        for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
            sudo apt-get remove $pkg;
        done
        echo "Adding Docker APT repository..."
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt-get update

        echo "Installing docker packages"
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        
        echo "Setting user permissions"
        sudo groupadd docker
        sudo usermod -aG docker $USER
    fi
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
