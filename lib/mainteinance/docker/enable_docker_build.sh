#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/http.sh


enable_docker_build() {
    enable_dns_client
    enable_https_client

    enable_dns_forward_client docker0
    enable_https_forward_client docker0
    enable_http_forward_client docker0

    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
}