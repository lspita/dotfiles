#!/bin/bash

# https://gist.github.com/WillianTomaz/a972f544cc201d3fbc8cd1f6aeccef51

# Code extracted from https://stuartleeks.com/posts/wsl-ssh-key-forward-to-windows/ 

# Configure ssh forwarding
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
PIPE=//./pipe/openssh-ssh-agent

# need `ps -ww` to get non-truncated command for matching
# use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s $PIPE"; echo $?)
if [[ $ALREADY_RUNNING != "0" ]]; then
    if [[ -S $SSH_AUTH_SOCK ]]; then
        # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
        rm $SSH_AUTH_SOCK
    fi
    # setsid to force new session to keep running
    # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s $PIPE",nofork &) >/dev/null 2>&1
fi
