DOTFILES_ROOT="$HOME/dotfiles"
DOTFILES_SCRIPTS="$HOME/.scripts"
DOTFILES_DUMPS="$DOTFILES_ROOT/dumps"

mkdir -p $DOTFILES_SCRIPTS
mkdir -p $DOTFILES_DUMPS

setopt NULL_GLOB

# https://unix.stackexchange.com/questions/9957/how-to-check-if-bash-can-print-colors
declare -A TEXT_COLORS

# check if stdout is a terminal
if [ -t 1 ]; then
    # see if it supports colors
    ncolors=$(tput colors)
    if [ -n "$ncolors" ] && [ $ncolors -ge 8 ]; then
        TEXT_COLORS[bold]="$(tput bold)"
        TEXT_COLORS[underline]="$(tput smul)"
        TEXT_COLORS[standout]="$(tput smso)"
        TEXT_COLORS[reset]="$(tput sgr0)"
        TEXT_COLORS[black]="$(tput setaf 0)"
        TEXT_COLORS[red]="$(tput setaf 1)"
        TEXT_COLORS[green]="$(tput setaf 2)"
        TEXT_COLORS[yellow]="$(tput setaf 3)"
        TEXT_COLORS[blue]="$(tput setaf 4)"
        TEXT_COLORS[magenta]="$(tput setaf 5)"
        TEXT_COLORS[cyan]="$(tput setaf 6)"
        TEXT_COLORS[white]="$(tput setaf 7)"
    fi
fi

__bold() {
    echo ${@:2} "${TEXT_COLORS[bold]}$1${TEXT_COLORS[reset]}"
}

__underline() {
    echo ${@:2} "${TEXT_COLORS[underline]}$1${TEXT_COLORS[reset]}"
}

__standout() {
    echo ${@:2} "${TEXT_COLORS[standout]}$1${TEXT_COLORS[reset]}"
}

__reset() {
    echo ${@:2} "${TEXT_COLORS[reset]}$1${TEXT_COLORS[reset]}"
}

__black() {
    echo ${@:2} "${TEXT_COLORS[black]}$1${TEXT_COLORS[reset]}"
}

__red() {
    echo ${@:2} "${TEXT_COLORS[red]}$1${TEXT_COLORS[reset]}"
}

__green() {
    echo ${@:2} "${TEXT_COLORS[green]}$1${TEXT_COLORS[reset]}"
}

__yellow() {
    echo ${@:2} "${TEXT_COLORS[yellow]}$1${TEXT_COLORS[reset]}"
}

__blue() {
    echo ${@:2} "${TEXT_COLORS[blue]}$1${TEXT_COLORS[reset]}"
}

__magenta() {
    echo ${@:2} "${TEXT_COLORS[magenta]}$1${TEXT_COLORS[reset]}"
}

__cyan() {
    echo ${@:2} "${TEXT_COLORS[cyan]}$1${TEXT_COLORS[reset]}"
}

__white() {
    echo ${@:2} "${TEXT_COLORS[white]}$1${TEXT_COLORS[reset]}"
}

__h1() {
    __bold "`__blue "$1"`" ${@:2}
}

__h2() {
    __bold "`__cyan "$1"`" ${@:2}
}

__h3() {
    __bold "`__magenta "$1"`" ${@:2}
}

__error() {
    __bold "`__red "$1"`" ${@:2}
}

__unset-func() {
    if declare -f "$1" > /dev/null; then
        unset -f "$1"
    fi
}

__command-exists() {
    command -v $@ > /dev/null
}

__function-exists() {
    declare -f $@ > /dev/null
}

__enable-service() {
    if __command-exists ${@:2} && ! systemctl is-active --quiet $1; then
        __h1 "Enabling $1 service"
        sudo systemctl enable --now $1
    fi
}

for script in $DOTFILES_SCRIPTS/init/*.sh; do
    source $script
done

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

for script in $DOTFILES_SCRIPTS/custom/*.sh; do
    source $script
done