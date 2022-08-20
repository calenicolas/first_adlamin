#!/bin/bash

source /usr/local/lib/adlamin/git.sh
source /usr/local/lib/adlamin/containers/docker.sh
source /usr/local/lib/adlamin/router/router.sh

deploy() {
  #ARGS
  VERSION=$1
  INTERFACE=$2
  PROJECT_NAME=$3
  GIT_REPO=$4
  IS_PERSISTENT=$5
  PERSISTENCE_PATH=$6
  NETWORK=$7

  IMAGE=$PROJECT_NAME:$VERSION

  clone $GIT_REPO TEMP_$PROJECT_NAME

  cd TEMP_$PROJECT_NAME
  docker_build $INTERFACE $IMAGE
  cd ..
  rm -rf TEMP_$PROJECT_NAME

  docker_stop $PROJECT_NAME

  if test $IS_PERSISTENT -eq 1; then
  IP=$(docker_run_with_persistence $IMAGE $PROJECT_NAME $NETWORK $PERSISTENCE_PATH)
  echo "Container wp ip is $IP"
  else
  IP=$(docker_run $IMAGE $PROJECT_NAME $NETWORK)
  echo "Container ip is $IP"
  fi

  add_route $NETWORK $IP 8080

  router_reload $NETWORK
}