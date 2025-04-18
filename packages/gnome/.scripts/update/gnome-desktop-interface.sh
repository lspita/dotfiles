__check-requirements() {
    __command-exists dconf
}

__dump-total() {
    dconf dump /org/gnome/desktop/interface/
}

__restore-total() {
    dconf load /org/gnome/desktop/interface/
}