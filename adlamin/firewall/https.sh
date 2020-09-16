#!/bin/bash

source $ADLAMIN_HOME/firewall/iptables.sh

enable_https_client(){

    enable_client tcp 443
}

disable_https_client(){

    disable_client tcp 443
}

enable_https_forward_client(){

    enable_forward_client eth0 $1 tcp 443
}

disable_https_forward_client(){

    disable_forward_client eth0 $1 tcp 443
}
