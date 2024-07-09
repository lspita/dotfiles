DCONF_DUMP_PATH="$DOTFILES_PATH/dumps/dconf.dump"

dconf-freeze() {
    dconf dump / > "$DCONF_DUMP_PATH"
}

dconf-restore() {
    dconf load / < "$DCONF_DUMP_PATH"
}
