# Touchpad scroll speed

See measure of touchpad under "Kernel specified touchpad size"

```sh
sudo libinput measure touchpad-size 100x100
```

Calculate new size, round decimals (0.5 scroll speed = half dimensions)

```sh
sudo libinput measure touchpad-size <new W>x<new H>
```

Copy output to specified file. Example:

```sh
-8<-------------------------- # copy content between
# Laptop model description (e.g. Lenovo X1 Carbon 5th)
evdev:name:PNP0C50:00 04F3:30AA Touchpad:dmi:*svnMicro-StarInternationalCo.,Ltd.:*pnModern15A11M**
 EVDEV_ABS_00=789:1829:10
 EVDEV_ABS_01=736:1638:9
 EVDEV_ABS_35=789:1829:10
 EVDEV_ABS_36=736:1638:9
-8<--------------------------
Instructions on what to do with this snippet are in /usr/lib/udev/hwdb.d/60-evdev.hwdb

# Example /etc/udev/hwdb.d/61-evdev-local.hwdb
```


Run this commands, restart and adjust pointer speed to match

```sh
sudo systemd-hwdb update
sudo udevadm trigger /dev/input/event*
```

# Lazygit

```sh
sudo dnf copr enable atim/lazygit
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

# VSCode

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

sudo dnf check-update
sudo dnf install code # or code-insiders
```

# Zerotier

```sh
curl -s https://install.zerotier.com | sudo bash
```

