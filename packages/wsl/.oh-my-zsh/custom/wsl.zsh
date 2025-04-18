if [ $(systemd-detect-virt) = "wsl" ]; then
    export BROWSER="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"

    clean-zone-identifier() {
        find . -type f -name "*:Zone.Identifier" -exec rm "{}" \;
    }

    local __wsl_hello_path=$HOME/wls-hello-sudo
    if [ ! -d $__wsl_hello_path ]; then
        wget http://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
        tar xvf release.tar.gz
        mv release $__wsl_hello_path
        $__wsl_hello_path/install.sh
    fi
fi