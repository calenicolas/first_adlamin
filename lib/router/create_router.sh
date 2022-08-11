#!/bin/bash

source /usr/local/lib/adlamin/mainteinance/docker.sh

create_router() {
    #ARGS
    NETWORK=$1
    ROUTER_IP=$2
    INTERFACE=$3

    enable_docker_build $INTERFACE

    docker build -t router_$NETWORK /usr/local/lib/adlamin/router/container

    docker stop router_$NETWORK || true

    docker run -d --rm --network=$NETWORK --ip=$ROUTER_IP --name router_$NETWORK router_$NETWORK

    disable_docker_build $INTERFACE
}
