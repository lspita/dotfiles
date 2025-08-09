if __is-wsl; then
    clean-zone-identifier() {
        find . -type f -name "*:Zone.Identifier" -exec rm "{}" \;
    }

    open() {
        local args=()
        for arg in "$@"; do
            args+=("\"$arg\"")
        done
        powershell.exe -Command "Start-Process ${args[*]}"
    }

    export BROWSER=open
else
    open() {
        xdg-open $@
    }
fi

alias purge-all="find . -mindepth 1 -maxdepth 1 -exec rm -rf '{}' \;"
