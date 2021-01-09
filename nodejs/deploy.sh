#!/bin/bash
echo "##############################"
echo "######## DEPLOY STAGE ########"
echo "##############################"
_nameOfContainer=$(docker ps | grep hello-node)

echo "Deploy is starting..."
echo "Pulling from Docker Hub..."
docker pull chuongnh140/hello-node:latest
if [[ $? -eq 0 ]]; then
  echo "Done pulling"
else
  echo "Error when pulling"
fi
echo "Starting container..."
if [[ $_nameOfContainer == '' ]]; then
  docker container run -d -p 3000:3000 \
  --name hello-node -e "APP_HOST=$(hostname)" \
  -e APP_VERSION=latest chuongnh140/hello-node:latest
else
  echo "Remove container is running with same name"
  _idOfContainer=$(docker ps | grep hello-node | awk '{print $1}')
  docker container stop $_idOfContainer && docker container rm $_idOfContainer
  docker container run -d -p 3000:3000 \
  --name hello-node -e "APP_HOST=$(hostname)" \
  -e APP_VERSION=latest chuongnh140/hello-node:latest
fi

if [[ $? -eq 0 ]]; then
  echo Done
else
  echo "Something went wrong!!!"
fi
