if [ -d /home/linuxbrew/ ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
    export HOMEBREW_NO_INSTALL_CLEANUP=true
    export HOMEBREW_NO_ENV_HINTS=true
fi
