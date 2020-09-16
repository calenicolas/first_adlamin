#!/bin/bash


# usage
# ./assign_traffic network url ip

add_server() {

    writeUpstreamCommand="write_server.sh $1 $2 $3"

    command="sudo docker exec router_$1 sh -c '$writeUpstreamCommand'"

    eval $command
}