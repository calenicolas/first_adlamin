#!/bin/bash

source $ADLAMIN_HOME/mainteinance/docker.sh

create_router() {
    enable_docker_build

    sudo docker build -t router_$1 /home/mulo/adlamin/router

    sudo docker stop router_$1

    sudo docker run -d --rm --network=$1 --ip=$2 --name router_$1 router_$1

    disable_docker_build
}