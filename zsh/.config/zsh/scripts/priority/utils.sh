alias battery-status='upower -i $(upower -e | grep -i BAT)'
alias open="xdg-open"
alias lg='lazygit'
alias c='code .'

purge-all() {
    rm -rf * 
    rm -rf .* 
    rm -rf */ 
    rm -rf .*/
}

