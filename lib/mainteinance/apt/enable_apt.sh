#!/bin/bash

source /usr/local/lib/adlamin/firewall/dns.sh
source /usr/local/lib/adlamin/firewall/http.sh
source /usr/local/lib/adlamin/firewall/https.sh

enable_apt() {
    enable_dns_client
    enable_http_client
    enable_https_client
}