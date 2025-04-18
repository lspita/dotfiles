__check-requirements() {
    __command-exists brew
}

__dump-packages() {
    brew list -1 --formulae --installed-on-request --full-name
}

__upgrade() {
    brew upgrade --formulae
}

__install() {
    xargs -I {} brew install --formula {}
}

__uninstall() {
    xargs -I {} brew uninstall --formula {}
}
