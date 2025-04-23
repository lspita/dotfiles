PRIORITY=1

__require() {
    __command-exists brew
}

__upgrade() {
    brew update
}

__clean() {
    brew cleanup
}