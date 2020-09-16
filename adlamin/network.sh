#/bin/bash

create_network() {
    sudo docker network rm $1
    sudo docker network create --opt com.docker.network.bridge.name=$1 --subnet=$2 $1
}