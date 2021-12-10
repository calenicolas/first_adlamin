#!/bin/bash


# usage
# ./assign_traffic network path ip port
# $NETWORK $IP $PORT
add_route() {

    writeUpstreamCommand="write_upstream.sh / $2 $3"

    command="sudo docker exec router_$1 sh -c '$writeUpstreamCommand'"

    eval $command
}