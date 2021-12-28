#!/bin/bash

source /usr/local/lib/adlamin/git.sh
source /usr/local/lib/adlamin/docker.sh
source /usr/local/lib/adlamin/router.sh

function deploy() {
  #ARGS
  VERSION=$1
  SERVICE_PATH=$2

  source $SERVICE_PATH/.service

  IMAGE=$PROJECT_NAME:$VERSION

  clone $GIT_REPO TEMP_$PROJECT_NAME

  cd TEMP_$PROJECT_NAME
  docker_build $IMAGE
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

  add_route $NETWORK $IP $PORT

  router_reload $NETWORK
}