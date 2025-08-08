__init() {
    if ! __command-exists docker; then
        # https://docs.docker.com/engine/install/debian/#install-using-the-repository
        __h3 "docker"
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

    if ! __command-exists nvidia-container-cli; then
        __h3 "NVIDIA Container Toolkit"
        # https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installation
        if __command-exists apt; then
            curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
            && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
                sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
                sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
            
            sudo apt-get update

            sudo apt-get install -y \
                nvidia-container-toolkit \
                nvidia-container-toolkit-base \
                libnvidia-container-tools \
                libnvidia-container1

            sudo nvidia-ctk runtime configure --runtime=docker
            sudo systemctl restart docker

            sudo nvidia-ctk runtime configure --runtime=containerd
            sudo systemctl restart containerd
        else
            __error "Unable to install NVIDIA Container Toolkit"
        fi
    fi
}