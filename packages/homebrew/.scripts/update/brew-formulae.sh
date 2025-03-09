# brew bundle dump not working in wsl2
# https://github.com/Homebrew/homebrew-bundle/issues/1226

list-packages() {
    brew list -1 --formulae --installed-on-request
}

upgrade-packages() {
    brew update
    brew upgrade
}

install-packages() {
    xargs -I {} brew install {}
}

uninstall-packages() {
    xargs -I {} brew uninstall {}
}
