# brew bundle dump not working in wsl2
# https://github.com/Homebrew/homebrew-bundle/issues/1226

__list-requirements() {
    echo brew
}

__list-packages() {
    brew list -1 --casks --full-name
}

__upgrade() {
    brew upgrade --casks
}

__install-packages() {
    xargs -I {} brew install --cask {}
}

__uninstall-packages() {
    xargs -I {} brew uninstall --cask {}
}
