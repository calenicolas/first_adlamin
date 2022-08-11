#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/http.sh


enable_docker_build() {
    #ARGS
    INTERFACE=$1

    enable_dns_client $INTEFACE
    enable_https_client $INTEFACE

    enable_dns_forward_client $INTEFACE docker0
    enable_https_forward_client $INTEFACE docker0
    enable_http_forward_client $INTEFACE docker0

    iptables -t nat -A POSTROUTING -o $INTEFACE -j MASQUERADE
}