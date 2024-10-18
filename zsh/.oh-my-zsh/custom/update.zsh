DNF_DUMP_PATH="${DOTFILES_PATH}/dumps/dnf.dump"
FLATPAK_DUMP_PATH="${DOTFILES_PATH}/dumps/flatpak.dump"
GNOME_EXTENSION_DUMP_PATH="${DOTFILES_PATH}/dumps/extensions.dump"
DCONF_DUMP_PATH="${DOTFILES_PATH}/dumps/dconf.dump"


full-upgrade() {
    # dnf
    sudo dnf upgrade
    sudo dnf autoremove

    # flatpak
    flatpak update

    # sdkman
    sdk selfupdate
    sdk upgrade
}

full-freeze() {
    # dnf
    dnf repoquery --userinstalled > "${DNF_DUMP_PATH}"

    # flatpak
    flatpak list --app --columns=application | xargs echo -n > "${FLATPAK_DUMP_PATH}"
    
    # gnome-extensions
    gnome-extensions list --enabled > "${GNOME_EXTENSION_DUMP_PATH}"

    # dconf
    dconf dump / > "${DCONF_DUMP_PATH}"
}

full-restore() {
    # dnf
    dnf install $(cat "${DNF_DUMP_PATH}")

    # flatpak
    flatpak install $(cat "${FLATPAK_DUMP_PATH}")

    # gnome-extensions
    # NOT POSSIBLE

    # dconf
    dconf load / < "${DCONF_DUMP_PATH}"
}


system-sync() {
    message="Backup $(date +"%Y-%m-%d %H:%M:%S %Z")"

    if [[ ${#} > 0 ]]; then
        message="${1}"
    fi
    
    full-upgrade
    full-freeze

    git status
    git -C "${DOTFILES_PATH}" add "${DOTFILES_PATH}"
    git -C "${DOTFILES_PATH}" commit -am "${message}"
    git -C  "${DOTFILES_PATH}" push
}