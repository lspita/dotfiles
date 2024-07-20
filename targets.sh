declare -A targets

DEFAULT_TARGET="DEFAULT/"
# targets[<package>]="<path> <use_sudo>")
targets["$DEFAULT_TARGET"]="$HOME false"
targets["dnf"]="/ true"
