# brew bundle dump not working in wsl2
# https://github.com/Homebrew/homebrew-bundle/issues/1226

__check-requirements() {
    __command-exists brew
}

__dump() {
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
