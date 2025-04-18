LINUX_BREW_ROOT=/home/linuxbrew/.linuxbrew/bin/brew
if [ -f $LINUX_BREW_ROOT ]; then
    eval "$($LINUX_BREW_ROOT shellenv)"
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
    export HOMEBREW_NO_INSTALL_CLEANUP=true
    export HOMEBREW_NO_ENV_HINTS=true
    
    source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
unset LINUX_BREW_ROOT