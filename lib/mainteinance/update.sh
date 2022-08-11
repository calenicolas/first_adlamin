#!/bin/bash

source /usr/local/lib/adlamin/firewall/http.sh
source /usr/local/lib/adlamin/firewall/https.sh
source /usr/local/lib/adlamin/firewall/dns.sh

INTERFACE=$1

enable_http_client $INTERFACE
enable_https_client $INTERFACE
enable_dns_client $INTERFACE

apt update
apt upgrade

disable_dns_client $INTERFACE
disable_http_client $INTERFACE
disable_https_client $INTERFACE
