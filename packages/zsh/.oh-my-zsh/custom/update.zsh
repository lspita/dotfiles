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

__sub-sub-section() {
    __init-colors
    echo "${TEXT_BOLD}${TEXT_MAGENTA}$1${TEXT_RESET}"
    __unset-colors
}

__unset-func() {
    if declare -f "$1" > /dev/null; then
        unset -f "$1"
    fi
}

__command-exists() {
    command -v $@ > /dev/null
}

__dump-file() {
    echo $DOTFILES_DUMPS/$1.dump
}

__run-script-action() {
    __section $1
    for script in $DOTFILES_SCRIPTS/update/*.sh; do
        local name=`basename ${script%.*}`
        source $script
        if 
            declare -f __list-requirements > /dev/null && 
            __list-requirements &&
            { [ $# -eq 1 ] || declare -f ${@:2} > /dev/null };
        then
            __sub-section $name
            __script-action
        fi
        __unset-func __list-requirements
        __unset-func __init
        __unset-func __list-packages
        __unset-func __upgrade
        __unset-func __clean
        __unset-func __uninstall-packages
        __unset-func __install-packages
    done
    __unset-func __script-action
}

__dotfiles-git-sha() {
    echo `git -C $DOTFILES_ROOT rev-parse HEAD`
}

system-pull() {
    __section "Pulling remote"
    local old_sha=`__dotfiles-git-sha`
    git -C $DOTFILES_ROOT pull
    if [[ `__dotfiles-git-sha` != $old_sha ]]; then
        __section "Reloading"
        make -C $DOTFILES_ROOT restow
        source $HOME/.zshrc
    fi
}

system-init() {
    __script-action() {
        __init
    }
    __run-script-action "Initializing" __init
}

system-restore() {
    __script-action() {
        local dump=`__dump-file $name`
        __list-packages | sort | comm -23 - $dump | __uninstall-packages # uninstall extra
        __list-packages | sort | comm -13 - $dump | __install-packages # install missing
    }
    __run-script-action "Restoring packages" __list-packages __uninstall-packages __install-packages
}

system-upgrade() {
    __script-action() {
        __upgrade
    }
    __run-script-action "Upgrading" __upgrade
}

system-clean() {
    __script-action() {
        __clean
    }
    __run-script-action "Cleaning up" __clean
}

system-dump() {
    __script-action() {
        __list-packages | sort > `__dump-file $name`
    }
    __run-script-action "Dumping packages" __list-packages
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

system-sync() {
    system-pull
    system-init
    system-restore
    system-upgrade
    system-clean
    system-dump
    system-backup $1
}
