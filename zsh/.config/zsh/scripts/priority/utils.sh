alias battery-status='upower -i $(upower -e | grep -i BAT)'
alias open="xdg-open"
alias lg='lazygit'

purge-all() {
    rm -rf * 
    rm -rf .* 
    rm -rf */ 
    rm -rf .*/
}

