# brew bundle dump not working in wsl2
# https://github.com/Homebrew/homebrew-bundle/issues/1226

__list-packages() {
    brew list -1 --installed-on-request
}

__upgrade-packages() {
    brew update
    brew upgrade
}

__install-packages() {
    xargs -I {} brew install {}
}

__uninstall-packages() {
    xargs -I {} brew uninstall {}
}
