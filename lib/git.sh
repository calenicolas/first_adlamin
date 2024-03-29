#!/bin/bash
source /usr/local/lib/adlamin/firewall/ssh.sh
source /usr/local/lib/adlamin/firewall/dns.sh

clone() {
    #ARGS
    GIT_REPO=$1
    REPO_PATH=$1
    INTERFACE=$3

    IDENTITY=~/.ssh/id_rsa/adlamin
    if test -f "$IDENTITY";
    then
        enable_dns_client $INTERFACE
        enable_ssh_client $INTERFACE

        git clone -i ~/.ssh/id_rsa/adlamin $GIT_REPO $REPO_PATH

        disable_ssh_client $INTERFACE
        disable_dns_client $INTERFACE
      else
        enable_dns_client $INTERFACE
        enable_ssh_client $INTERFACE

        git clone $GIT_REPO $REPO_PATH

        disable_ssh_client $INTERFACE
        disable_dns_client $INTERFACE
    fi
}