LINUX_BREW_ROOT=/home/linuxbrew/.linuxbrew/bin/brew
if [ -f $LINUX_BREW_ROOT ]; then
    eval "$($LINUX_BREW_ROOT shellenv)"
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
    export HOMEBREW_NO_INSTALL_CLEANUP=true
    export HOMEBREW_NO_ENV_HINTS=true
fi
unset LINUX_BREW_ROOT