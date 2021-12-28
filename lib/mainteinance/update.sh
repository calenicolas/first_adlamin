#!/bin/bash

source /usr/local/lib/adlamin/firewall/http.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/dns.sh

enable_http_client
enable_https_client
enable_dns_client

apt update
apt upgrade

disable_dns_client
disable_http_client
disable_https_client
