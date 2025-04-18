__check-requirements() {
    __command-exists dconf
}

__dump-total() {
    dconf dump /org/gnome/shell/extensions/
}

__restore-total() {
    dconf load /org/gnome/shell/extensions/
}