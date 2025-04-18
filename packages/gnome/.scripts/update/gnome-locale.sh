__check-requirements() {
    __command-exists dconf
}

__dump-total() {
    dconf dump /system/locale
}

__restore-total() {
    dconf load /system/locale
}