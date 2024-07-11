BAT_DARK="OneHalfDark"
BAT_LIGHT="OneHalfLight"

if [ $(gsettings get org.gnome.desktop.interface color-scheme) = "'prefer-dark'" ]; then
    export BAT_THEME=$BAT_DARK
else
    export BAT_THEME=$BAT_LIGHT
fi