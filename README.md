# Zsh

```sh
sudo dnf install zsh
chsh -s $(which zsh) # make zsh default shell

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k # p10k
```

# Docker

```sh
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker.service
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```

# Chrome

```sh
sudo dnf install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install google-chrome-stable
```

# Tlp

```sh
sudo dnf remove power-profiles-daemon
sudo dnf install tlp tlp-rdw
sudo systemctl enable --now tlp.service NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

# VSCode

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

sudo dnf check-update
sudo dnf install code # or code-insiders
```

# Syncthing
```sh
systemctl --user enable --now syncthing.service
```
