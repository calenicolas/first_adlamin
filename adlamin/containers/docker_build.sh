#!/bin/bash

source $ADLAMIN_HOME/mainteinance/docker.sh

docker_build() {
    enable_docker_build

    sudo docker build --rm -t $1 .

    disable_docker_build
}