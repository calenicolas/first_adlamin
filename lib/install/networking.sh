#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh
source /usr/local/lib/adlamin/network.sh
source /usr/local/lib/adlamin/router/router.sh

function create_dmz() {
  # ARGS
  PUBLIC_INTERFACE=$1
  DMZ_NETWORK=$2
  DMZ_ROUTER_IP=$3

  create_network dmz $DMZ_NETWORK
  create_router dmz $DMZ_ROUTER_IP

  forward_to_server_from_any $PUBLIC_INTERFACE dmz $DMZ_ROUTER_IP tcp 8080
}

function create_internal() {
  # ARGS
  INTERFACE=$1
  NETWORK=$2
  ROUTER_IP=$3

  create_network internal $NETWORK
  create_router internal $ROUTER_IP

  forward_to_server_from_any $INTERFACE dmz $ROUTER_IP tcp 8080
}

