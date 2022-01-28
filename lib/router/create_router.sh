#!/bin/bash

source /usr/local/lib/adlamin/mainteinance/docker.sh

create_router() {
    enable_docker_build

    docker build -t router_$1 /usr/local/lib/adlamin/router

    docker stop router_$1

    docker run -d --rm --network=$1 --ip=$2 --name router_$1 router_$1

    disable_docker_build
}