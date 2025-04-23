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

# Other programs

## WSL Hello Sudo

Use Windows Hello for sudo prompt

Repo: https://github.com/nullpo-head/WSL-Hello-sudo

```sh
wget http://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz -O wsl-hello-sudo.tar.gz
tar xvf wsl-hello-sudo.tar.gz
rm wsl-hello-sudo.tar.gz
mv release .wsl-hello-sudo
cd .wsl-hello-sudo
./install.sh
cd -
```

You can call 'sudo pam-auth-update' to enable/disable WSL Hello authentication.

If you want to uninstall WSL-Hello-sudo, run uninstall.sh

## Italian keyboards

Custom italian keyboards for development (can be found in [assets](./assets/keyboards))
- [devita](./assets/keyboards/devita/): italian + dev additions
    - base: italian
    - altgr + ì = ~
    - altgr + ' = `
- [hpita](./assets/keyboards/hpita/): devita + fix for stupid Fn layout (HP OmniBook Ultra Flip 14)
    - base: italian
    - altgr + ì = ~
    - altgr + ' = `
    - altgr + l = <
    - altgr + shift + l = >

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
