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

__function-exists() {
    declare -f $@ > /dev/null
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
            __function-exists __check-requirements && 
            __check-requirements &&
            { [ $# -eq 1 ] || __function-exists ${@:2} };
        then
            __sub-section $name
            __script-action
        fi
        __unset-func __check-requirements
        __unset-func __init
        __unset-func __dump
        __unset-func __upgrade
        __unset-func __clean
        __unset-func __install
        __unset-func __uninstall
        __unset-func __post-install
    done
    __unset-func __script-action
}

__dotfiles-git-sha() {
    echo `git -C $DOTFILES_ROOT rev-parse HEAD`
}

system-pull() {
    __section "Pulling remote"
    local old_sha=`__dotfiles-git-sha`
    make -C $DOTFILES_ROOT delete
    git -C $DOTFILES_ROOT pull
    make -C $DOTFILES_ROOT restow
    if [[ `__dotfiles-git-sha` != $old_sha ]]; then
        __section "Reloading"
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
        __dump | sort | comm -23 - $dump | __uninstall # uninstall extra
        __dump | sort | comm -13 - $dump | __install # install missing
        if __function-exists __post-install; then
            __post-install
        fi
    }
    __run-script-action "Restoring" __dump __uninstall __install
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
        __dump | sort > `__dump-file $name`
    }
    __run-script-action "Dumping" __dump
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
