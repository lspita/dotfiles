__init() {
    if ! __command-exists docker; then
        # https://docs.docker.com/engine/install/debian/#install-using-the-repository
        __h3 "Docker"
        if __command-exists apt; then
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
        else
            __error "Unable to install docker"
        fi
    fi
}