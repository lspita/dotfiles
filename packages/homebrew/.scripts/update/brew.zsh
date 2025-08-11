__require() {
    __command-exists brew
}

__upgrade() {
    brew update
    brew upgrade
}

__clean() {
    brew cleanup
}