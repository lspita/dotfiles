if __is-wsl; then
    export BROWSER="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"

    clean-zone-identifier() {
        find . -type f -name "*:Zone.Identifier" -exec rm "{}" \;
    }

    alias winget=winget.exe
fi
