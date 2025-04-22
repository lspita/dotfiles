__packages-filter() {
    # no filter: cat
    __require-command apt apt |
    __require-command cargo cargo |
    __require-command dnf dnf |
    __require-command docker docker |
    __require-command flatpak flatpak |
    __require-command git git |
    __require-command "gnome.*" gnome-shell dconf |
    __require-command go go |
    __require-path homebrew /home/linuxbrew/ |
    __require-command input-remapper input-remapper-gtk |
    __require-command jupyter jupyter |
    __require wsl "test \`systemd-detect-virt\` = \"wsl\"" |
    __require-command zsh zsh |
    __require-path zsh $HOME/.oh-my-zsh
}

declare -A target
declare -A sudo

# default is a reserved name, don't use it as a package

target[default]=$HOME
sudo[default]=false

target[gnome-system]=/
sudo[gnome-system]=true