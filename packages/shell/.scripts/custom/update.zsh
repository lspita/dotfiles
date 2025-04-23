__dump-file() {
    echo $DOTFILES_DUMPS/$1.dump
}

__run-script-action() {
    __unset-all() {
        unset PRIORITY
        __unset-function __check-requirements
        __unset-function __init
        __unset-function __dump-packages
        __unset-function __dump-total
        __unset-function __upgrade
        __unset-function __clean
        __unset-function __install
        __unset-function __uninstall
        __unset-function __restore-total
    }

    local scripts=()
    for script in $DOTFILES_SCRIPTS/update/*.zsh; do
        source $script
        PRIORITY=${PRIORITY:-0}
        if [[ ! "$PRIORITY" =~ ^[0-9]+$ ]]; then
            echo "$script PRIORITY must be a non-negative integer"
        elif 
            (! __function-exists __require || __require) &&
            ([ $# -eq 0 ] || __function-exists $@)
        ; then
            scripts+="$PRIORITY:$script"
        fi
        __unset-all
    done
    scripts=($(printf "%s\n" "${scripts[@]}" | sort -n)) # sort array
    for script in ${scripts[@]}; do
        script=${script#*":"} # remove priority prefix
        local name=$(basename ${script%.*})
        source $script
        __h2 "$name"
        __script-action
        __unset-all
    done
    __unset-function __unset-all
    __unset-function __script-action
}

__dotfiles-git-sha() {
    git -C $DOTFILES_ROOT rev-parse HEAD
}

system-pull() {
    __h1 "Pulling remote"
    local old_sha=$(__dotfiles-git-sha)
    __h2 "Unlinking packages"
    make -C $DOTFILES_ROOT delete
    __h2 "Pulling repo"
    git -C $DOTFILES_ROOT pull
    __h2 "Relinking packages"
    make -C $DOTFILES_ROOT restow
    if [[ $(__dotfiles-git-sha) != $old_sha ]]; then
        __h2 "Applying changes"
        source $HOME/.zshrc
        return 0
    else
        __h2 "No changes to apply"
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
    if [[ $1 = false ]]; then
        return
    fi
    __h1 "Restoring"
    __script-action() {
        local dump=$(__dump-file $name)
        __dump-packages | sort | comm -23 - $dump | __uninstall # uninstall extra
        __dump-packages | sort | comm -13 - $dump | __install # install missing
    }
    __run-script-action __dump-packages __uninstall __install
    __script-action() {
        local dump=$(__dump-file $name)
        local temp_file=$(mktemp)
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
        __dump-packages | sort > $(__dump-file $name)
    }
    __run-script-action __dump-packages
    __script-action() {
        __dump-total > $(__dump-file $name)
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

    if __yes-no "Continue with backup?"; then
        # push changes
        local time_stamp=$(date +"%Y-%m-%d %H:%M:%S %Z")
        message=${1:-"Backup $time_stamp"}
        git -C $DOTFILES_ROOT commit -m "$message"
        git -C $DOTFILES_ROOT push
    fi
}

system-sync() {
    local message=$1
    FORCE_CHANGES=${FORCE_CHANGES:-false}
    if [[ $FORCE_CHANGES != true && $FORCE_CHANGES != false ]]; then
        echo "FORCE_CHANGES be a boolean true|false" 1>&2
        return 1
    fi
    system-pull
    local pull_result=$?
    local has_changes=false
    if [[ $FORCE_CHANGES = true || $pull_result = 0 ]]; then
        has_changes=true
    fi
    system-init $has_changes
    system-restore $has_changes
    system-upgrade $has_changes
    system-clean $has_changes
    system-dump $has_changes
    system-backup $1
    unset FORCE_CHANGES
}
