DUMP_ROOT="$DOTFILES_ROOT/dumps"
BREW_DUMP="$DUMP_ROOT/brew.dump"

mkdir -p $DUMP_ROOT

system-freeze() {
    # homebrew
    brew leaves -r > $BREW_DUMP
}

system-backup() {
    git -C $DOTFILES_ROOT add $DOTFILES_ROOT
    git -C $DOTFILES_ROOT status

    if [[ $(git -C $DOTFILES_ROOT status --porcelain | wc -l) -eq 0 ]]; then
        return # no changes
    fi

    echo -n "Continue with backup? [Y/n] "
    read YESNO
    YESNO=${YESNO:-"y"}
    if [[ $YESNO =~ ^[Yy]$ ]]; then
        # push changes
        message=${1:-"Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"}
        git -C $DOTFILES_ROOT commit -m $message
        git -C $DOTFILES_ROOT push
    fi
}

system-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade -y
    sudo apt autoremove

    # homebrew
    brew update
    brew upgrade
}

system-restore() {
    # homebrew
    brew leaves -r | comm -23 - $BREW_DUMP | xargs -I {} brew uninstall {} # uninstall extra
    brew leaves -r | comm -13 - $BREW_DUMP | xargs -I {} brew install {} # install missing
}

system-sync() {
    git -C $DOTFILES_ROOT pull
    
    system-restore
    system-upgrade
    system-freeze
    system-backup $1
}
