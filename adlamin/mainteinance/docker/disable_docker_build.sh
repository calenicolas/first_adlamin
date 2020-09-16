#!/bin/bash

source $ADLAMIN_HOME/firewall/dns.sh
source $ADLAMIN_HOME/firewall/https.sh
source $ADLAMIN_HOME/firewall/http.sh

disable_docker_build() {
    disable_dns_client
    disable_https_client

    disable_dns_forward_client docker0
    disable_https_forward_client docker0
    disable_http_forward_client docker0

    sudo iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
}