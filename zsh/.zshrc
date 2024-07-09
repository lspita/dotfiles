# local bins
export PATH="$HOME/.local/bin:$PATH"

# source custom scripts
export DOTFILES_PATH="$HOME/dotfiles"
CUSTOM_SCRIPTS_PATH="$HOME/.config/zsh/scripts"

mkdir -p "$CUSTOM_SCRIPTS_PATH"
for script in $CUSTOM_SCRIPTS_PATH/*; do
	source "$script"
done
