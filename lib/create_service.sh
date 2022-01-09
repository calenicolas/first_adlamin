#!/bin/bash

source /usr/local/lib/adlamin/firewall/iptables.sh
source /usr/local/lib/adlamin/network.sh
source /usr/local/lib/adlamin/router.sh

function create_service() {
  #ARGS
  URL=$1
  DOMAIN_NAME=$2
  SERVICE_PATH=$3

  source $SERVICE_PATH/.service

  create_network $NETWORK $SUBNET
  create_router $NETWORK $ROUTER_IP

  # DMZ

  if test $IS_PUBLIC -eq 1; then

    # Permite el trafico desde la dmz al router del servicio
    forward_to_server dmz $NETWORK $DMZ_ROUTER_IP $ROUTER_IP tcp 8080

    # Permite el trafico desde el router del servicio a los hosts(subnet) del servicio
    forward_to_server $NETWORK $NETWORK $ROUTER_IP $SUBNET tcp $PORT

    # Suma en el router de la dmz la url con la ip del router del servicio
    add_server dmz $PROJECT_NAME $URL.$DOMAIN_NAME $ROUTER_IP
    router_reload dmz
  fi

  # INTERNAL

  if test $IS_PRIVATE -eq 1; then
    # Permite el trafico desde internal al router del servicio
    forward_to_server internal $NETWORK $INTERNAL_ROUTER_IP $ROUTER_IP tcp 8080

    # Permite el trafico el router del servicio hacia el router de internal
    forward_to_server $NETWORK internal $ROUTER_IP $INTERNAL_ROUTER_IP tcp 8080

    # Suma en el router de internal la url con la ip del router del servicio
    add_server internal $PROJECT_NAME internal.$URL.$DOMAIN_NAME $ROUTER_IP
    router_reload internal
  fi
}