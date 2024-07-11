GNOME_EXTENSION_DUMP_PATH="$DOTFILES_PATH/dumps/extensions.dump"

extensions-freeze() {
    gnome-extensions list --enabled > "$GNOME_EXTENSION_DUMP_PATH"
}

extensions-restore() {
    echo "Not implemented :("
}
