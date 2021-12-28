#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/http.sh

disable_docker_build() {
    disable_dns_client
    disable_https_client

    disable_dns_forward_client docker0
    disable_https_forward_client docker0
    disable_http_forward_client docker0

    iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
}