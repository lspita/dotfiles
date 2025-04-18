__check-requirements() {
    __command-exists dconf
}

__dump-total() {
    dconf dump /org/gnome/mutter/
}

__restore-total() {
    dconf load /org/gnome/mutter/
}