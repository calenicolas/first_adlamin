#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/http.sh
source /usr/local/lib/adlamin/firewall/https.sh

enable_apt() {
    #ARGS
    INTERFACE=$1

    enable_dns_client $INTERFACE
    enable_http_client $INTERFACE
    enable_https_client $INTERFACE
}