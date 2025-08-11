__run-script-action() {
    __unset-all() {
        unset PRIORITY
        __unset-function __check-requirements
        __unset-function __init
        __unset-function __dump-packages
        __unset-function __dump-total
        __unset-function __upgrade
        __unset-function __clean
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
    __h1 "Getting changes"
    local old_sha=$(__dotfiles-git-sha)
    __h2 "Unlinking packages"
    make -C $DOTFILES_ROOT delete
    __h2 "Pulling repo"
    git -C $DOTFILES_ROOT pull
    __h2 "Relinking packages"
    make -C $DOTFILES_ROOT stow
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
    system-pull
    system-init
    system-upgrade
    system-clean
    system-backup $1
}

system-override() {
    # system-pull
    # system-init
    system-upgrade
    system-clean
    system-backup $1
}
