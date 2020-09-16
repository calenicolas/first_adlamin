#!/bin/bash

getIpAddress () {

    ipAddress=`sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1`

    echo $ipAddress
}

docker_run() {
    sleep 5s

    ID=$(sudo docker run --network="$3" --name="$2" -d --rm $1)

    IP=$(getIpAddress $ID)

    echo $IP
}