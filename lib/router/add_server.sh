#!/bin/bash

add_server() {
    # ARGS
    NETWORK=$1
    PROJECT_NAME=$2
    URL=$3
    ROUTER_IP=$4

    writeUpstreamCommand="write_server.sh $PROJECT_NAME $URL $ROUTER_IP"

    command="docker exec router_$NETWORK sh -c '$writeUpstreamCommand'"

    eval $command
}