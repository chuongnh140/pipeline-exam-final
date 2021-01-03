#!/bin/bash
echo "##############################"
echo "######## DEPLOY STAGE ########"
echo "##############################"
_nameOfContainerjs=$(docker ps | grep hello-node)
_nameOfContainerpy=$(docker ps | grep hello-python)
_dockerimagepy=chuongnh140/hello-python
_dockerimagejs=chuongnh140/hello-node
_dockertag=latest


#deploy python_app
echo "Deploy python_app is starting..."
echo "Pulling from Docker Hub..."

docker pull $_dockerimagepy:$_dockertag

if [[ $? -eq 0 ]]; then
  echo "Done pulling"
else
  echo "Error when pulling"
fi

echo "Starting container python_app..."

if [[ $_nameOfContainerpy == '' ]]; then
  docker container run -d -p 5000:5000 \
  --name hello-python -e "APP_HOST=$(hostname)" \
  -e APP_VERSION=latest $_dockerimagepy:$_dockertag
else
  echo "Remove container is running with same name"
  _idOfContainerpy=$(docker ps | grep hello-python | awk '{print $1}')
  docker container stop $_idOfContainerpy && docker container rm $_idOfContainerpy
  docker container run -d -p 5000:5000 \
  --name hello-python -e "APP_HOST=$(hostname)" \
  -e APP_VERSION=latest $_dockerimagepy:$_dockertag
fi

if [[ $? -eq 0 ]]; then
  echo "Done deploy Python App"
else
  echo "Something went wrong!!!"
fi

#deploy nodejs_app
echo "Deploy nodejs_app is starting..."
echo "Pulling from Docker Hub..."

docker pull $_dockerimagejs:$_dockertag

if [[ $? -eq 0 ]]; then
  echo "Done pulling"
else
  echo "Error when pulling"
fi

echo "Starting container nodejs_app..."

if [[ $_nameOfContainerjs == '' ]]; then
  docker container run -d -p 3000:3000 \
  --name hello-nodejs -e "APP_HOST=$(hostname)" \
  -e APP_VERSION=latest $_dockerimagejs:$_dockertag
else
  echo "Remove container is running with same name"
  _idOfContainerjs=$(docker ps | grep hello-node | awk '{print $1}')
  docker container stop $_idOfContainerjs && docker container rm $_idOfContainerjs
  docker container run -d -p 3000:3000 \
  --name hello-node -e "APP_HOST=$(hostname)" \
  -e APP_VERSION=latest $_dockerimagejs:$_dockertag
fi

if [[ $? -eq 0 ]]; then
  echo "Done deploy Nodejs App"
else
  echo "Something went wrong!!!"
fi
