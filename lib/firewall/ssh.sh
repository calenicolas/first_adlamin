#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh

enable_ssh_client(){

    enable_client eth0 tcp 22
}

disable_ssh_client(){

    disable_client tcp 22
}
