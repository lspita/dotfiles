UPDATE_SCRIPTS=$SCRIPTS_ROOT/update

__section() {
    __init-colors
    echo "${TEXT_BOLD}${TEXT_BLUE}$1${TEXT_RESET}"
    __unset-colors
}

__sub-section() {
    __init-colors
    echo "${TEXT_BOLD}${TEXT_CYAN}$1${TEXT_RESET}"
    __unset-colors
}

__script-name() {
    echo `basename ${1%.*}`
}

__dump-file() {
    local file=$DUMPS_ROOT/$1.dump
    touch $file
    echo $file
}

__run-script-action() {
    __section $1
    for script in $UPDATE_SCRIPTS/*; do
        local name=`__script-name $script`
        local dump_file=`__dump-file $name`
        source $script
        if ! command -v `__list-requirements` > /dev/null; then
            continue
        fi
        __sub-section $name
        __script-action
        unset -f __list-requirements
        unset -f __list-packages
        unset -f __upgrade-packages
        unset -f __uninstall-packages
        unset -f __install-packages
    done
    unset -f __script-action
}

system-dump() {
    __script-action() {
        __list-packages | sort > $dump_file
    }
    __run-script-action "Dumping packages"
}

system-backup() {
    __section "Pushing changes"
    git -C $DOTFILES_ROOT add $DOTFILES_ROOT
    git -C $DOTFILES_ROOT status

    if [[ $(git -C $DOTFILES_ROOT status --porcelain | wc -l) -eq 0 ]]; then
        return # no changes
    fi

    __init-colors
    echo -n "${TEXT_BOLD}Commit and push? [Y/n] ${TEXT_RESET}"
    __unset-colors
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
    __script-action() {
        __upgrade-packages
    }
    __run-script-action "Upgrading packages"
}

system-restore() {
    __script-action() {
        __list-packages | sort | comm -23 - $dump_file | __uninstall-packages # uninstall extra
        __list-packages | sort | comm -13 - $dump_file | __install-packages # install missing
    }
    __run-script-action "Restoring packages"
}

system-pull() {
    __section "Pulling remote"
    git -C $DOTFILES_ROOT pull
    source $HOME/.zshrc
}

system-sync() {
    system-pull
    system-restore
    system-upgrade
    system-dump
    system-backup $1
}
