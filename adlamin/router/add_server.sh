#!/bin/bash


# usage
# ./assign_traffic network url ip

add_server() {

    writeUpstreamCommand="add_server.sh $2 $3"

    command="sudo docker exec router_$1 sh -c '$writeUpstreamCommand'"

    sudo docker exec router_$1 nginx -s reload

    eval $command
}