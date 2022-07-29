#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh
source /usr/local/lib/adlamin/network.sh
source /usr/local/lib/adlamin/router.sh

create_service() {
  #ARGS
  URL=$1
  DOMAIN_NAME=$2
  SERVICE_PATH=$3
  PROJECT_NAME=$4
  DMZ_ROUTER_IP=$5
  INTERNAL_ROUTER_IP=$6
  GIT_REPO=$7


  echo "subnet [172.28.0.0/16]"
  read SUBNET
  echo "router ip [172.28.255.254]"
  read ROUTER_IP
  echo "port [8080]"
  read PORT
  read IS_PRIVATE
  read IS_PUBLIC
  read IS_PERSISTENT
  read PERSISTENCE_PATH

  create_network $PROJECT_NAME $SUBNET
  create_router $PROJECT_NAME $ROUTER_IP
  setup_router $IS_PUBLIC $IS_PRIVATE $PROJECT_NAME $DMZ_ROUTER_IP $ROUTER_IP $SUBNET $URL $DOMAIN_NAME $INTERNAL_ROUTER_IP
}