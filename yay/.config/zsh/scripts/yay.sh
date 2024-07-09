YAY_DUMP_PATH="$DOTFILES_PATH/dumps/yay.dump"

yay-autoremove(){
	yay -Qdtq | yay -Rs -
}

yay-freeze() {
    yay -Qqe > "$YAY_DUMP_PATH"
}

yay-restore() {
    yay --needed --noconfirm -S $(cat $1)
}

yay-upgrade() {
	yay -Syu
    yay-autoremove
}
