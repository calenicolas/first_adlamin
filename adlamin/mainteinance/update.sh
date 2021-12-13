#!/bin/bash

source $ADLAMIN_HOME/firewall/http.sh
source $ADLAMIN_HOME/firewall/https.sh
source $ADLAMIN_HOME/firewall/dns.sh

enable_http_client
enable_https_client
enable_dns_client

apt update
apt upgrade

disable_dns_client
disable_http_client
disable_https_client
