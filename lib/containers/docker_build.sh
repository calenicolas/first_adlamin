#!/bin/bash

source /usr/local/lib/adlamin/mainteinance/docker.sh

docker_build() {
    enable_docker_build

    docker build -t $1 .

    disable_docker_build
}