#!/bin/bash

source /usr/local/lib/adlamin/mainteinance/docker.sh

docker_build() {
    #ARGS
    INTERFACE=$1
    IMAGE=$2

    enable_docker_build $INTERFACE

    docker build -t $IMAGE .

    disable_docker_build $INTERFACE
}