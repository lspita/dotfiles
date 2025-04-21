__dump-file() {
    echo $DOTFILES_DUMPS/$1.dump
}

__run-script-action() {
    for script in $DOTFILES_SCRIPTS/update/*.sh; do
        local name=`basename ${script%.*}`
        source $script
        if
            __function-exists __check-requirements && 
            __check-requirements && 
            ( [ $# -eq 0 ] || __function-exists $@ ); 
        then
            __h2 $name
            __script-action
        fi
        __unset-func __check-requirements
        __unset-func __init
        __unset-func __dump-packages
        __unset-func __dump-total
        __unset-func __upgrade
        __unset-func __clean
        __unset-func __install
        __unset-func __uninstall
        __unset-func __restore-total
    done
    __unset-func __script-action
}

__dotfiles-git-sha() {
    echo `git -C $DOTFILES_ROOT rev-parse HEAD`
}

system-pull() {
    __h1 "Pulling remote"
    local old_sha=`__dotfiles-git-sha`
    make -C $DOTFILES_ROOT delete
    git -C $DOTFILES_ROOT pull
    make -C $DOTFILES_ROOT restow
    if [[ `__dotfiles-git-sha` != $old_sha ]]; then
        __h2 "Applying changes"
        source $HOME/.zshrc
        return 0
    else
        return 1
    fi
}

system-init() {
    __h1 "Initializing"
    __script-action() {
        __init
    }
    __run-script-action __init
}

system-restore() {
    if [ ! $1 -eq 0 ]; then
        return
    fi
    __h1 "Restoring"
    __script-action() {
        local dump=`__dump-file $name`
        __dump-packages | sort | comm -23 - $dump | __uninstall # uninstall extra
        __dump-packages | sort | comm -13 - $dump | __install # install missing
    }
    __run-script-action __dump-packages __uninstall __install
    __script-action() {
        local dump=`__dump-file $name`
        local temp_file=`mktemp`
        __dump-total > $temp_file
        if ! diff -q $temp_file $dump > /dev/null; then
            __restore-total < $dump
        fi
    }
    __run-script-action __dump-total __restore-total
}

system-upgrade() {
    __h1 "Upgrading"
    __script-action() {
        __upgrade
    }
    __run-script-action __upgrade
}

system-clean() {
    __h1 "Cleaning up"
    __script-action() {
        __clean
    }
    __run-script-action __clean
}

system-dump() {
    __h1 "Dumping"
    __script-action() {
        __dump-packages | sort > `__dump-file $name`
    }
    __run-script-action __dump-packages
    __script-action() {
        __dump-total > `__dump-file $name`
    }
    __run-script-action __dump-total
}

system-backup() {
    __h1 "Checking changes"
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
    local has_changes=$?
    system-init $has_changes
    system-restore $has_changes
    system-upgrade $has_changes
    system-clean $has_changes
    system-dump $has_changes
    system-backup $1
}
