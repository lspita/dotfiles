PRIORITY=1 # after docker

__require() {
    __command-exists apt && __command-exists nvidia-smi
}

__init() {
    if __command-exists docker && ! __command-exists nvidia-container-cli; then
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

__dump-packages() {
    apt-mark showmanual | grep nvidia
}

__install() {
    xargs -I {} sudo apt install -y {}
}

__uninstall() {
    xargs -I {} sudo apt purge -y {}
}
