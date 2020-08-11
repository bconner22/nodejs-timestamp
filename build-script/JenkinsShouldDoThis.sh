#!/bin/bash
export DOCKER_USER=$1
pushd ../
docker build -t $DOCKER_USER/node-app .                                                                                                          
docker run -p 54130:80 -d $DOCKER_USER/node-app | tee container_id.txt
CONTAINER_ID=$(<container_id.txt)
npm install -g newman
newman run tests/unit-test.json
if [ $? -eq 0 ]
then
  echo "Unit Test successful, pushing to dockerhub"
 
  if docker info | grep "name"; then
    docker push $DOCKER_USER/node-app
  else
    echo "Please login to docker"
    docker login --username=$DOCKER_USER
    docker push $DOCKER_USER/node-app
  fi
else
  echo "Unit Test unsuccessful" >&2
fi
echo "Cleaning up, killing this container"
docker kill $CONTAINER_ID
rm -rf container_id.txt