#!/bin/bash

function setup_router() {
  # ARGS
  IS_PUBLIC=$1
  IS_PRIVATE=$2
  PROJECT_NAME=$3
  DMZ_ROUTER_IP=$4
  ROUTER_IP=$5
  SUBNET=$6
  DOMAIN_NAME=$7
  INTERNAL_ROUTER_IP=$8

  # DMZ

  if test $IS_PUBLIC -eq 1; then

    # Permite el trafico desde la dmz al router del servicio
    forward_to_server dmz $PROJECT_NAME $DMZ_ROUTER_IP $ROUTER_IP tcp 8080

    # Permite el trafico desde el router del servicio a los hosts(subnet) del servicio
    forward_to_server $PROJECT_NAME $PROJECT_NAME $ROUTER_IP $SUBNET tcp $PORT
    forward_to_server $PROJECT_NAME $PROJECT_NAME $ROUTER_IP $SUBNET tcp $PORT

    # Suma en el router de la dmz la url con la ip del router del servicio
    add_server dmz $PROJECT_NAME $PROJECT_NAME.$DOMAIN_NAME $ROUTER_IP
    router_reload dmz
  fi

  # INTERNAL

  if test $IS_PRIVATE -eq 1; then
    # Permite el trafico desde internal al router del servicio
    forward_to_server internal $PROJECT_NAME $INTERNAL_ROUTER_IP $ROUTER_IP tcp 8080

    # Permite el trafico el router del servicio hacia el router de internal
    forward_to_server $PROJECT_NAME internal $ROUTER_IP $INTERNAL_ROUTER_IP tcp 8080

    # Suma en el router de internal la url con la ip del router del servicio
    add_server internal $PROJECT_NAME $PROJECT_NAME.internal.$DOMAIN_NAME $ROUTER_IP
    router_reload internal
  fi
}