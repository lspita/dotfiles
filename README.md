# Pipewire fix

If the audio is not working until you switch device

```sh
sudo pacman -R wireplumber # conflict
sudo pacman -Syu pipewire-media-session
```

# Yay

```sh
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
yay -Y --gendb
yay -Y --devel --save
yay -Syu
```

# Gnome

```sh
yay -Rs epiphany gnome-maps gnome-connections epiphany # remove bloat
sudo usermod -aG video $USER # make gnome-camera work
sudo cp -Lf ~/.config/monitors.xml /var/lib/gdm/.config/monitors.xml # copy monitors config to root
```

# Zsh

```sh
yay -S zsh
chsh -s $(which zsh) # make zsh default shell

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k # p10k
```

# Services

```sh
sudo systemctl enable --now bluetooth
systemctl --user enable --now pipewire
```

## User services

```sh
systemctl enable --user --now $HOME/.config/systemd/user/*.service
```

# Snapper

```sh
yay -S snapper snap-pac
sudo umount /.snapshots
sudo rm -r /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a
sudo chmod 750 /.snapshots
```

## After config

```sh
sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
```

# Locale

```sh
sudo locale-gen
```

# Docker

```sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable --now docker.service
```

# Systemd-boot

as sudo (`sudo su`)
- `cd /boot/loader`
- In loader.conf, change "timeout <x>" to "timeout 0"
- `cd /boot/loader/entries`
- Rename default entry to arch.conf and remove the others
- In arch.conf, edit "options root=... rw ..." to "options root=... rw quiet splash ..."
- `bootctl install`


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
yay -S tlp tlp-rdw tlpui
sudo systemctl enable --now tlp.service NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
```