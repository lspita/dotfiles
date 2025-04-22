__packages-list() {
    __default-list |
    __require-command gnome-shell "gnome.*"
}

declare -A target
declare -A sudo

# default is a reserved name, don't use it as a package

target[default]=$HOME
sudo[default]=false

target[gnome-system]=/
sudo[gnome-system]=true