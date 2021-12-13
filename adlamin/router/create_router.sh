#!/bin/bash

source $ADLAMIN_HOME/mainteinance/docker.sh

create_router() {
    enable_docker_build

    docker build -t router_$1 $ADLAMIN_HOME/router

    docker stop router_$1

    docker run -d --rm --network=$1 --ip=$2 --name router_$1 router_$1

    disable_docker_build
}