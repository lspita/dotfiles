__check-requirements() {
    __command-exists dconf
}

__dump-total() {
    dconf dump / 
}

__restore_total() {
    dconf load / < $1
}