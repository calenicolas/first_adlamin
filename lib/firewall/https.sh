#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh

enable_https_client(){
    #ARGS
    INTERFACE=$1

    enable_client $INTERFACE tcp 443
}

disable_https_client(){
    #ARGS
    INTERFACE=$1

    disable_client $INTERFACE tcp 443
}

enable_https_forward_client(){
    #ARGS
    INTERFACE=$1
    CLIENT=$2

    enable_forward_client $INTERFACE $CLIENT tcp 443
}

disable_https_forward_client(){
    #ARGS
    INTERFACE=$1
    CLIENT=$2

    disable_forward_client $INTERFACE $CLIENT tcp 443
}
