#!/bin/bash

echo "##############################"
echo "######## DEPLOY STAGE ########"
echo "##############################"
_nameOfContainer=$(docker ps | grep hello-python)

echo "Deploy is starting..."
echo "Pulling from Docker Hub..."
docker pull chuongnh140/hello-python:latest
if [[ $? -eq 0 ]]; then
  echo "Done pulling"
else
  echo "Error when pulling"
fi
echo "Starting container..."
if [[ $_nameOfContainer == '' ]]; then
  docker container run -d -p 5000:5000 \
  --name hello-python -e "HOST_NAME=$(hostname)" \
  -e MY_TAG=latest chuongnh140/hello-python:latest
else
  echo "Remove container is running with same name"
  _idOfContainer=$(docker ps | grep hello-python | awk '{print $1}')
  docker container stop $_idOfContainer && docker container rm $_idOfContainer
  docker container run -d -p 5000:5000 \
  --name hello-python -e "HOST_NAME=$(hostname)" \
  -e MY_TAG=latest chuongnh140/hello-python:latest
fi

if [[ $? -eq 0 ]]; then
  echo Done
else
  echo "Something went wrong!!!"
fi
