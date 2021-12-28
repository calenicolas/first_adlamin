#!/bin/bash

router_reload() {
    docker exec router_$1 nginx -s reload
}