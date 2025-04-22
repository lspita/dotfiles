export BROWSER="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"

clean-zone-identifier() {
    find . -type f -name "*:Zone.Identifier" -exec rm "{}" \;
}

# WSL_HELLO_PATH=$HOME/wsl-hello-sudo
# if [ ! -d $WSL_HELLO_PATH ]; then
#     wget http://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
#     tar xvf release.tar.gz
#     mv release $WSL_HELLO_PATH
#     $WSL_HELLO_PATH/install.sh
# fi
# unset WSL_HELLO_PATH