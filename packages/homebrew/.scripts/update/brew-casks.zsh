PRIORITY=1 # after general brew

__require() {
    __command-exists brew
}

__dump-packages() {
    brew list -1 --casks --full-name
}

__upgrade() {
    brew upgrade --casks
}

__install() {
    xargs -I {} brew install --cask {}
}

__uninstall() {
    xargs -I {} brew uninstall --cask {}
}
