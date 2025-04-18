> [!IMPORTANT]
> If you want to use this dotfiles, remember to adapt them to your needs,
> because they aren't modular or configurable (ex. user name and email in the 
> [git config file](./packages/git/.gitconfig) or some paths starting with /home/lspita)

# Utils

## Set ZSH as default shell

```sh
command -v zsh | sudo tee -a /etc/shells # prevent zsh invalid shell with brew
chsh -s $(which zsh) # set zsh as default
```

## WSL Hello sudo

http://github.com/nullpo-head/WSL-Hello-sudo/

```sh
cd $HOME
wget http://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
tar xvf release.tar.gz
mv release wsl-hello-sudo
cd wsl-hello-sudo
./install.sh
```

## SSH private key permissions

```sh
sudo chmod 600 id_ed25519
```
