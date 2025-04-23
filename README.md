> [!IMPORTANT]
> If you want to use this dotfiles, remember to adapt them to your needs,
> because they aren't modular or configurable (ex. user name and email in the 
> [git config file](./packages/git/.gitconfig) or some paths starting with /home/lspita)

# Install

```sh
source install.sh
```

Variables
 - `MESSAGE`: commit message for system-sync
 - `FORCE_REINSTALL`: true to reinstall existing things, like brew and oh-my-zsh (default: false)

# Utils

## Set ZSH as default shell

```sh
which zsh | sudo tee -a /etc/shells # prevent zsh invalid shell with brew
chsh -s $(which zsh) # set zsh as default
```

## SSH private key permissions

```sh
sudo chmod 600 ~/.ssh/id_ed25519
```
