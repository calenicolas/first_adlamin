#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/http.sh
source /usr/local/lib/adlamin/firewall/https.sh

disable_apt() {
    disable_dns_client
    disable_http_client
    disable_https_client
}