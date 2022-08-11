#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/http.sh

disable_docker_build() {
    #ARGS
    INTERFACE=$1

    disable_dns_client $INTERFACE
    disable_https_client $INTERFACE

    disable_dns_forward_client $INTERFACE docker0
    disable_https_forward_client $INTERFACE docker0
    disable_http_forward_client $INTERFACE docker0

    iptables -t nat -D POSTROUTING -o $INTERFACE -j MASQUERADE
}