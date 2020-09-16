#!/bin/bash

source $ADLAMIN_HOME/firewall/iptables.sh

enable_dns_client(){

    enable_client tcp 53
    enable_client udp 53
}

enable_dns_forward_client(){

    enable_forward_client eth0 $1 tcp 53
    enable_forward_client eth0 $1 udp 53
}

disable_dns_forward_client(){

    disable_forward_client eth0 $1 tcp 53
    disable_forward_client eth0 $1 udp 53
}

disable_dns_client(){

    disable_client tcp 53
    disable_client udp 53
}
