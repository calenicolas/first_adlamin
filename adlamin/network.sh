#/bin/bash

create_network() {
    docker network rm $1
    docker network create --opt com.docker.network.bridge.name=$1 --subnet=$2 $1
}