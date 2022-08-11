#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/http.sh


enable_docker_build() {
    #ARGS
    INTERFACE=$1

    enable_dns_client $INTERFACE
    enable_https_client $INTERFACE

    enable_dns_forward_client $INTERFACE docker0
    enable_https_forward_client $INTERFACE docker0
    enable_http_forward_client $INTERFACE docker0

    iptables -t nat -A POSTROUTING -o $INTERFACE -j MASQUERADE
}