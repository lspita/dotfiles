# Gnome

```sh
sudo cp -Lf ~/.config/monitors.xml /var/lib/gdm/.config/monitors.xml # copy monitors config to root
```

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

# User dirs

```sh
cd $HOME
mv Desktop desktop
mv Downloads downloads
mv Templates templates
mv Public public
mv Documents documents
mv Music music
mv Pictures pictures
mv Videos videos
```

# Tlp

```sh
sudo dnf remove power-profiles-daemon
sudo dnf install tlp tlp-rdw
sudo systemctl enable --now tlp.service NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

Symlink not working, copy manually

```sh
sudo cp -r tlp/etc/tlp.conf /etc
```

# VSCode

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

sudo dnf check-update
sudo dnf install code # or code-insiders
```
