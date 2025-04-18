__DCONF_DIRS=(
    "/org/gnome/desktop/"
    "/org/gnome/shell/"
    "/system/locale/"
    "/org/gnome/mutter/"
    "/org/gnome/settings-daemon/"
    "/org/gnome/tweaks/"
)

__check-requirements() {                
    __command-exists dconf
}

__dump-total() {
    for dir in "${__DCONF_DIRS[@]}"; do
        echo ">>>$dir"
        dconf dump "$dir"
        echo "<<<"
    done
}

__restore-total() {
    local current_path=""
    local temp_file=""

    local old_ifs="$IFS"
    while IFS= read -r line; do
        if [[ "$line" == ">>>"* ]]; then
            current_path="${line#>>>}"
            temp_file=`mktemp`
        elif [[ "$line" == "<<<" ]]; then
	    dconf load "$current_path" < "$temp_file"
    	    rm "$temp_file"
        elif [[ "$temp_file" != "" ]]; then
            echo "$line" >> "$temp_file"
        fi
    done
    export IFS="$old_ifs"
}