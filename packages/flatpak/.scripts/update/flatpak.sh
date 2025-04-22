__dump-packages() {
    flatpak list --columns=application | tail -n +1
}

__upgrade() {
    flatpak update -y
}

__install() {
    xargs -I {} flatpak install -y {}
}

__uninstall() {
    xargs -I {} flatpak remove -y {}
}
