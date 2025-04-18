# brew bundle dump not working in wsl2
# https://github.com/Homebrew/homebrew-bundle/issues/1226

__check-requirements() {
    __command-exists brew
}

__dump() {
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
