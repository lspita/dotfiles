__list-requirements() {
    echo dnf
}

__init() {
    # docker repo
    # https://docs.docker.com/engine/install/fedora/#install-using-the-repository
    if ! sudo dnf repo list | grep -q "docker-ce"; then
        echo "Uninstalling docker potential conflicts"
        sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
        
        echo "Adding Docker repository..."
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    
        echo "Installing docker packages"
        sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        echo "Starting docker daemon"
        sudo systemctl enable --now docker

        echo "Setting user permissions"
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker

        echo "Test with hello world"
        docker run hello-world
    fi
}

__list-packages() {
    dnf repoquery --userinstalled --qf "%{name}\n"
}

__upgrade() {
    sudo dnf upgrade
}

__clean() {
    sudo dnf autoremove
}

__install-packages() {
    xargs -I {} sudo dnf install -y {}
}

__uninstall-packages() {
    xargs -I {} sudo dnf remove -y {}
}
