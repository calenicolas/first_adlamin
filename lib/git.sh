#!/bin/bash
source /usr/local/lib/adlamin/firewall/ssh.sh
source /usr/local/lib/adlamin/firewall/dns.sh

clone() {
    #ARGS
    GIT_REPO=$1
    REPO_PATH=$1
    INTERFACE=$3

    enable_dns_client $INTERFACE
    enable_ssh_client $INTERFACE

    git clone $GIT_REPO $REPO_PATH

    disable_ssh_client $INTERFACE
    disable_dns_client $INTERFACE
}