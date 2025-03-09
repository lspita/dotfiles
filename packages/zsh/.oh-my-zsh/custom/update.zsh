UPDATE_SCRIPTS=$SCRIPTS_ROOT/update

section() {
    init_colors
    echo "${TEXT_BOLD}${TEXT_BLUE}$1${TEXT_RESET}"
    unset_colors
}

sub-section() {
    init_colors
    echo "${TEXT_BOLD}${TEXT_CYAN}$1${TEXT_RESET}"
    unset_colors
}

get_name() {
    echo `basename ${1%.*}`
}

get_dump_file() {
    local file=$DUMPS_ROOT/$1.dump
    touch $file
    echo $file
}

foreach_script() {
    section $1
    for script in $UPDATE_SCRIPTS/*; do
        local name=`get_name $script`
        sub-section $name
        local dump_file=`get_dump_file $name`
        source $script
        script_action
        unset -f list-packages
        unset -f upgrade-packages
        unset -f uninstall-packages
        unset -f install-packages
    done
    unset -f script_action
}

system-dump() {
    script_action() {
        list-packages > $dump_file
    }
    foreach_script "Dumping packages"
}

system-backup() {
    git -C $DOTFILES_ROOT add $DOTFILES_ROOT
    git -C $DOTFILES_ROOT status

    if [[ $(git -C $DOTFILES_ROOT status --porcelain | wc -l) -eq 0 ]]; then
        return # no changes
    fi

    init_colors
    echo -n "${TEXT_BOLD}Continue with backup? [Y/n] ${TEXT_RESET}"
    unset_colors
    read YESNO
    YESNO=${YESNO:-"y"}
    if [[ $YESNO =~ ^[Yy]$ ]]; then
        section "Pushing changes"
        # push changes
        message=${1:-"Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"}
        git -C $DOTFILES_ROOT commit -m $message
        git -C $DOTFILES_ROOT push
    fi
}

system-upgrade() {
    script_action() {
        upgrade-packages
    }
    foreach_script "Upgrading packages"
}

system-restore() {
    script_action() {
        list-packages | comm -23 - $dump_file | uninstall-packages # uninstall extra
        list-packages | comm -13 - $dump_file | install-packages # install missing
    }
    foreach_script "Restoring packages"
}

system-sync() {
    section "Pulling remote"
    git -C $DOTFILES_ROOT pull
    
    system-restore
    system-upgrade
    system-freeze
    system-backup $1
}
