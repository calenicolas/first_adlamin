#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh

enable_dns_client(){
    #ARGS
    INTERFACE=$1

    enable_client $INTERFACE tcp 53
    enable_client $INTERFACE udp 53
}

enable_dns_forward_client(){
    #ARGS
    INTERFACE=$1
    CLIENT=$2

    enable_forward_client $INTERFACE $CLIENT tcp 53
    enable_forward_client $INTERFACE $CLIENT udp 53
}

disable_dns_forward_client(){
    #ARGS
    INTERFACE=$1
    CLIENT=$1

    disable_forward_client $INTERFACE $CLIENT tcp 53
    disable_forward_client $INTERFACE $CLIENT udp 53
}

disable_dns_client(){
    #ARGS
    INTERFACE=$1

    disable_client $INTERFACE tcp 53
    disable_client $INTERFACE udp 53
}
