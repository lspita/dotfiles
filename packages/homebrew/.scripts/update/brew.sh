__check-requirements() {
    __command-exists brew
}

__upgrade() {
    brew update
}

__clean() {
    brew cleanup
}