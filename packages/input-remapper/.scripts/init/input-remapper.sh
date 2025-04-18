if __command-exists input-remapper-gtk && ! systemctl is-active --quiet input-remapper; then
    __section "Enabling input remapper service"
    sudo systemctl enable --now input-remapper
fi