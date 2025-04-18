if __command-exists dconf; then
    INTERFACE_FONT="interface;/org/gnome/desktop/interface/font-name;Adwaita Sans;12"
    DOCUMENT_FONT="documents;/org/gnome/desktop/interface/document-font-name;Adwaita Sans;12"
    MONOSPACE_FONT="monospace;/org/gnome/desktop/interface/monospace-font-name;FiraCode Nerd Font;12"

    for font in $INTERFACE_FONT $DOCUMENT_FONT $MONOSPACE_FONT; do
        type=`echo $font | cut -d ";" -f 1`
        location=`echo $font | cut -d ";" -f 2`
        name=`echo $font | cut -d ";" -f 3`
        size=`echo $font | cut -d ";" -f 4`
        if [ "`dconf read "$location"`" != "'$name $size'"  ]; then
            if fc-list | grep -iq "$name"; then
                __h1 "Setting $type font to $name $size"
                dconf write "$location" "'$name $size'"
            else
                __error "Cannot set $type font: $name doesn't exist"
            fi
        fi
    done
fi