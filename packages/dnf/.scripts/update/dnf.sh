__list-requirements() {
    __command-exists dnf
}

__init() {
    # docker repo
    # https://docs.docker.com/engine/install/fedora/#install-using-the-repository
    if ! __command-exists docker; then
        __sub-sub-section docker
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
        sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        
        sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        sudo systemctl enable --now docker

        sudo groupadd docker
        sudo usermod -aG docker $USER
    fi
    if ! __command-exists code; then
        __sub-sub-section code
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

        dnf check-update
        sudo dnf install -y code # or code-insiders
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
