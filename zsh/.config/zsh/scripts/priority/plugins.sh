PLUGINS_PATH="/usr/share/zsh/plugins"
PLUGINS=("zsh-autosuggestions" "zsh-syntax-highlighting")

mkdir -p "$PLUGINS_PATH"
for p in "${PLUGINS[@]}"; do
    p_full="$PLUGINS_PATH/$p/$p.zsh"
    if [[ -f "$p_full" ]]; then
        source "$p_full"
    fi
done