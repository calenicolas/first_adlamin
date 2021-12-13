#!/bin/bash

source $ADLAMIN_HOME/firewall/dns.sh
source $ADLAMIN_HOME/firewall/https.sh
source $ADLAMIN_HOME/firewall/http.sh


enable_docker_build() {
    enable_dns_client
    enable_https_client

    enable_dns_forward_client docker0
    enable_https_forward_client docker0
    enable_http_forward_client docker0

    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
}