FLATPAK_DUMP_PATH="$DOTFILES_PATH/dumps/flatpak.dump"

flatpak-freeze() {
    flatpak list --app --columns=application | xargs echo -n > $1
}

flatpak-restore() {
    flatpak install $(cat $"$FLATPAK_DUMP_PATH") -y
}

flatpak-upgrade() {
	flatpak update
}
