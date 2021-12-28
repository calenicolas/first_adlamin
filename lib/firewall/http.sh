#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh

enable_http_client(){
    enable_client eth0 tcp 80
}

disable_http_client(){

    disable_client tcp 80
}

enable_http_forward_client(){

    enable_forward_client eth0 $1 tcp 80
}

disable_http_forward_client(){

    disable_forward_client eth0 $1 tcp 80
}
