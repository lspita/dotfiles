if __is-wsl; then
    export BROWSER="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"

    clean-zone-identifier() {
        find . -type f -name "*:Zone.Identifier" -exec rm "{}" \;
    }

    alias winget=winget.exe
    alias open="explorer.exe"
else
    alias open="xdg-open"
fi

alias purge-all="find . -mindepth 1 -maxdepth 1 -exec rm -rf '{}' \;"
