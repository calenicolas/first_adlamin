#!/bin/bash

source $ADLAMIN_HOME/firewall/dns.sh
source $ADLAMIN_HOME/firewall/http.sh
source $ADLAMIN_HOME/firewall/https.sh

disable_apt() {
    disable_dns_client
    disable_http_client
    disable_https_client
}