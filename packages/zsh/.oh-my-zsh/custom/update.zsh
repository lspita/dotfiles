DUMP_ROOT="$DOTFILES_ROOT/dumps"
BREW_DUMP="$DUMP_ROOT/brew.dump"

mkdir -p $DUMP_ROOT

full-freeze() {
    # homebrew
    brew leaves -r > $BREW_DUMP

    # push changes
    message=${1:-"Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"}

    git -C $DOTFILES_ROOT add $DOTFILES_ROOT
    git -C $DOTFILES_ROOT status
    git -C $DOTFILES_ROOT commit -m $message
    git -C $DOTFILES_ROOT push
}

full-upgrade() {
    # apt
    sudo apt update && sudo apt full-upgrade -y
    sudo apt autoremove

    # homebrew
    brew update
    brew upgrade
}

full-restore() {
    # homebrew
    xargs brew install --quiet < $BREW_DUMP
}

system-sync() {
    git -C $DOTFILES_ROOT pull
    make -C $DOTFILES_ROOT restow
    
    full-restore
    full-upgrade
    full-freeze
}
