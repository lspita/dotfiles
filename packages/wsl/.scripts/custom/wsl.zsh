if __is-wsl; then
    # ssh agent bridge https://www.rebelpeon.com/bitwarden-ssh-agent-on-wsl2/
    if __win-command-exists npiperelay.exe; then
        source $DOTFILES_SCRIPTS/ssh-agent-bridge.sh
    else
        echo "npiperelay not found, ssh agent bridge disabled. install it with winget install albertony.npiperelay" >&2
    fi
fi