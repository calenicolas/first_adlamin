#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh

enable_http_client(){
    #ARGS
    INTERFACE=$1

    enable_client $INTERFACE tcp 80
}

disable_http_client(){
    #ARGS
    INTERFACE=$1

    disable_client $INTERFACE tcp 80
}

enable_http_forward_client(){
    #ARGS
    INTERFACE=$1
    CLIENT=$2

    enable_forward_client $INTERFACE $CLIENT tcp 80
}

disable_http_forward_client(){
    #ARGS
    INTERFACE=$1
    CLIENT=$2

    disable_forward_client $INTERFACE $CLIENT tcp 80
}
