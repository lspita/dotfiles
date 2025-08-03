#!/bin/bash

# https://www.rebelpeon.com/bitwarden-ssh-agent-on-wsl2/

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
PIPE=//./pipe/openssh-ssh-agent

ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0   ]; then
    rm -f $SSH_AUTH_SOCK
    ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s $PIPE",nofork &) >/dev/null 2>&1
fi
