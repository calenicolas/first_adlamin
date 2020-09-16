#!/bin/bash
source $ADLAMIN_HOME/firewall/ssh.sh
source $ADLAMIN_HOME/firewall/dns.sh

clone() {
    enable_dns_client
    enable_ssh_client

    git clone $1 $2

    disable_ssh_client
    disable_dns_client
}