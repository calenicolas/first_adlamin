#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh

enable_ssh_client(){
    #ARGS
    INTERFACE=$1

    enable_client $INTERFACE tcp 22
}

disable_ssh_client(){
    #ARGS
    INTERFACE=$1

    disable_client $INTERFACE tcp 22
}
