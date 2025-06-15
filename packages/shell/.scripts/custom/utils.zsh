if __is-wsl; then
    clean-zone-identifier() {
        find . -type f -name "*:Zone.Identifier" -exec rm "{}" \;
    }

    alias winget=winget.exe
    alias open="explorer.exe"
    export BROWSER="explorer.exe"
else
    alias open="xdg-open"
fi

alias purge-all="find . -mindepth 1 -maxdepth 1 -exec rm -rf '{}' \;"
