#!/bin/bash

router_reload() {
    sudo docker exec router_$1 nginx -s reload
}