declare -A targets

DEFAULT_TARGET="DEFAULT/"
# targets[<package>]="<path> <use_sudo>")
targets["$DEFAULT_TARGET"]="$HOME false"
targets["bluetooth/"]="/ true"
targets["locale/"]="/ true"
targets["snapper/"]="/ true"
targets["systemd/"]="/ true"
targets["tlp/"]="/ true"
