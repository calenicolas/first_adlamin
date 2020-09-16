#!/bin/bash

source $ADLAMIN_HOME/firewall/dns.sh
source $ADLAMIN_HOME/firewall/http.sh
source $ADLAMIN_HOME/firewall/https.sh

enable_apt() {
    enable_dns_client
    enable_http_client
    enable_https_client
}