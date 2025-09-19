#!/usr/bin/env bash

SUCCESSFUL_CONFIG_LINE="Configured by init-server script"

CONF_FILES=(".bashrc" ".tmux.conf" ".vimrc")
REPO_CONF_PATHS=("bash" "tmux" "vim")

# Verify if user is root
if [[ "$EUID" -eq 0 ]]; then
    CONFIGS_PATH="configs/root"
else
    CONFIGS_PATH="configs/user"
fi

for i in "${!CONF_FILES[@]}"; do
    SRC="${CONFIGS_PATH}/${REPO_CONF_PATHS[$i]}/${CONF_FILES[$i]}"
    DEST="$HOME/${CONF_FILES[$i]}"
    
    if ! grep -q "$SUCCESSFUL_CONFIG_LINE" "$DEST" 2>/dev/null; then
        cat "$SRC" >> "$DEST"
    fi  
done

echo "✔ Initial configuration completed, please reboot server."
cd ..
rm -rf init-server