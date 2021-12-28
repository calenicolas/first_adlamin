#!/bin/bash
source /usr/local/lib/adlamin/firewall/ssh.sh
source /usr/local/lib/adlamin/firewall/dns.sh

clone() {
    enable_dns_client
    enable_ssh_client

    git clone $1 $2

    disable_ssh_client
    disable_dns_client
}