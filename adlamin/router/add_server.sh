#!/bin/bash


# usage
# ./assign_traffic network service url ip

add_server() {

    writeUpstreamCommand="write_server.sh $2 $3 $4"

    command="docker exec router_$1 sh -c '$writeUpstreamCommand'"

    eval $command
}