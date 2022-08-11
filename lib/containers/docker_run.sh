#!/bin/bash

getIpAddress () {

    ipAddress=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1`

    echo $ipAddress
}

docker_run() {

    ID=$(docker run --network="$3" --name="$2" -d --rm $1)

    docker logs -f --until=12s $1

    sleep 5s

    IP=$(getIpAddress $ID)

    echo $IP
}

docker_run_with_persistence() {

    ID=$(docker run -v=$2:$4 --network="$3" --name="$2" -d --rm $1)

    sleep 5s

    IP=$(getIpAddress $ID)

    echo $IP
}