#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/http.sh
source /usr/local/lib/adlamin/firewall/https.sh

disable_apt() {
    #ARGS
    INTERFACE=$1

    disable_dns_client $INTERFACE
    disable_http_client $INTERFACE
    disable_https_client $INTERFACE
}