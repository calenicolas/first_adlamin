#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh
source /usr/local/lib/adlamin/network.sh
source /usr/local/lib/adlamin/router/router.sh

create_dmz() {
  # ARGS
  PUBLIC_INTERFACE=$1
  DMZ_NETWORK=$2
  DMZ_ROUTER_IP=$3

  create_network dmz $DMZ_NETWORK
  create_router dmz $DMZ_ROUTER_IP $PUBLIC_INTERFACE

  forward_to_server_from_any $PUBLIC_INTERFACE dmz $DMZ_ROUTER_IP tcp 8080
}

create_internal() {
  # ARGS
  INTERFACE=$1
  NETWORK=$2
  ROUTER_IP=$3

  create_network internal $NETWORK
  create_router internal $ROUTER_IP $PUBLIC_INTERFACE

  forward_to_server_from_any $INTERFACE dmz $ROUTER_IP tcp 8080
}

setup_dmz(){
  echo "DMZ Source: [eth0]"
  read PUBLIC_INTERFACE

  echo "DMZ Network Range: [172.18.0.0/24]"
  read DMZ_NETWORK

  echo "DMZ Router IP: [172.18.0.2]"
  read DMZ_ROUTER_IP

  echo "creating dmz"...
  create_dmz $PUBLIC_INTERFACE $DMZ_NETWORK $DMZ_ROUTER_IP
  echo "done"
}

setup_internal(){
  echo "Internal Source: [eth0]"
  read INTERNAL_INTERFACE

  echo "Internal Network Range: [172.19.0.0/24]"
  read INTERNAL_NETWORK

  echo "Internal Router IP: [172.19.0.2]"
  read INTERNAL_ROUTER_IP

  echo "creating internal"...
  create_internal $INTERNAL_INTERFACE $INTERNAL_NETWORK $INTERNAL_ROUTER_IP
  echo "done"
}