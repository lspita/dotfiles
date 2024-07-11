export DOTFILES_PATH="$HOME/dotfiles"

# -- zsh --

SAVEHIST=1000
HISTFILE=~/.zsh_history

# -- local bins --
export PATH="$HOME/.local/bin:$PATH"

# -- custom scripts --

# Prioritized scripts are executed before the others. Remember to add the script to the order array
ZSH_SCRIPTS_PATH="$HOME/.config/zsh/scripts"
ZSH_PRIORITY_SCRIPTS_PATH="$ZSH_SCRIPTS_PATH/priority"
ZSH_PRIORITY_SCRIPTS_ORDER=("ls.sh" "utils.sh" "p10k.sh" "plugins.sh")

for s in "${ZSH_PRIORITY_SCRIPTS_ORDER[@]}"; do
    s_full="$ZSH_PRIORITY_SCRIPTS_PATH/$s"
    if [[ -f "$s_full" ]]; then
        source "$s_full"
    fi
done

mkdir -p "$ZSH_SCRIPTS_PATH"
for s in $ZSH_SCRIPTS_PATH/*; do
	source "$s"
done
