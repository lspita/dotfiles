UPDATE_SCRIPTS=$SCRIPTS_ROOT/update

get_name() {
    echo `basename ${1%.*}`
}

get_dump_file() {
    local file=$DUMPS_ROOT/$1.dump
    touch $file
    echo $file
}

foreach_script() {
    echo "-- $1 --"
    for script in $UPDATE_SCRIPTS/*; do
        local name=`get_name $script`
        echo "- $name"
        local dump_file=`get_dump_file $name`
        source $script
        script_action
        unset -f list-packages
        unset -f upgrade-packages
        unset -f uninstall-packages
        unset -f install-packages
        echo ""
    done
    unset -f script_action
}

system-freeze() {
    script_action() {
        list-packages > $dump_file
    }
    foreach_script "freeze"
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
    script_action() {
        upgrade-packages
    }
    foreach_script "upgrade"
}

system-restore() {
    script_action() {
        list-packages | comm -23 - $dump_file | uninstall-packages # uninstall extra
        list-packages | comm -13 - $dump_file | install-packages # install missing
    }
    foreach_script "restore"
}

system-sync() {
    git -C $DOTFILES_ROOT pull
    
    system-restore
    system-upgrade
    system-freeze
    system-backup $1
}
