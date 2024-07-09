# Gnome

```sh
yay -Rs epiphany gnome-maps gnome-connections epiphany # remove bloat
sudo usermod -aG video $USER # make gnome-camera work
```

# Packages

```sh
yay -S python python-pip make
```

# Zsh

```sh
yay -S zsh
chsh -s $(which zsh) # make zsh default shell
```

# Services

```sh
sudo systemctl enable --now bluetooth
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
