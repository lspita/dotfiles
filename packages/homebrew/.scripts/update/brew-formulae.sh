# brew bundle dump not working in wsl2
# https://github.com/Homebrew/homebrew-bundle/issues/1226

__list-requirements() {
    echo brew
}

__list-packages() {
    brew list -1 --formulae --installed-on-request --full-name
}

__upgrade() {
    brew upgrade --formulae
}

__install-packages() {
    xargs -I {} brew install --formula {}
}

__uninstall-packages() {
    xargs -I {} brew uninstall --formula {}
}
