MESSAGE=${MESSAGE:-""}
FORCE_REINSTALL=${FORCE_REINSTALL:-false}

if [[ ! $FORCE_REINSTALL =~ true|false ]]; then
    echo "Second argument must be true or false" 1>&2
    return 1
fi

REQUIRED_COMMANDS=(zsh make curl git stow)
if ! which ${REQUIRED_COMMANDS[*]} > /dev/null; then
    (
        echo "To continue, please install"
        for cmd in ${REQUIRED_COMMANDS[@]}; do
            echo " - $cmd"
        done
    ) 1>&2 
    return 2
fi
unset REQUIRED_COMMANDS

__yes-no() {
    echo -n "$1 [Y/n]: "
    local answer
    read answer
    answer=${answer:-"y"}
    [[ $answer =~ ^[Yy]$ ]]
}

echo "--- oh my zsh ---"
echo ""
OHMYZSH_DIR=$HOME/.oh-my-zsh
if [ -d $OHMYZSH_DIR ]; then
    echo "oh-my-zsh already installed ($OHMYZSH_DIR found)"
    if [ $FORCE_REINSTALL = true ] || __yes-no "reinstall?"; then
        echo "removing oh-my-zsh dir"
        rm -rf $OHMYZSH_DIR
    fi
fi
if [ ! -d $OHMYZSH_DIR ]; then
    echo "running install script"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
unset OHMYZSH_DIR

# homebrew

echo "--- homebrew ---"
echo ""
BREW_DIR=/home/linuxbrew
if [ -d $BREW_DIR ]; then
    echo "homebrew already installed ($BREW_DIR found)"
    if [ $FORCE_REINSTALL = true ] || __yes-no "reinstall?"; then
        if which brew > /dev/null; then
            echo "uninstalling packages"
            brew list --formula | xargs brew uninstall --formula --force
            brew list --cask | xargs brew uninstall --cask --force
        fi
        echo "uninstalling brew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    fi
fi
if [ ! -d $BREW_DIR ]; then
    echo "running install script"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
unset BREW_DIR

echo "--- dotfiles ---"
echo ""
rm $HOME/.zshrc
make


echo "--- system sync ---"
echo ""
zsh -c "
cd $HOME && 
source .zshrc && 
FORCE_CHANGES=true system-sync \"$MESSAGE\"
"

echo "--- zsh ---"
if [[ $SHELL != $(which zsh) ]] && __yes-no "Set zsh as default shell?"; then
    chsh -s $(which zsh)
fi

if __yes-no "Enter zsh?"; then
    exec zsh
fi

unset __yes-no
unset MESSAGE
unset FORCE_REINSTALL
