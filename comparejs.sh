#!/bin/bash
_imageNamejs="chuongnh140/hello-node:latest"
_statusImage="Image is up to date for $_imageNamejs"
_statusPulling=$(docker pull chuongnh140/hello-node:latest | grep Status | sed 's/Status: //')
_dateNow=`date +"%d-%m-%Y %r"`
if [[ $_statusImage == $_statusPulling ]]; then
  #echo "Nothing to do"
  echo "$_dateNow     Image is up to date for $_imageNamejs" >> /var/log/nodejs-app.log
else
  echo "$_dateNow     Had found new image $_imageNamejs" >> /var/log/nodejs-app.log
  echo "$_dateNow     Done pulling new image $_imageNamejs" >> /var/log/nodejs-app.log
  _nameOfContainer=$(docker ps | grep hello-node)
  echo "$_dateNow     Deploy is starting..." >> /var/log/nodejs-app.log
  echo "$_dateNow     Starting container..." >> /var/log/nodejs-app.log
  if [[ $_nameOfContainer == '' ]]; then
    docker container run -d -p 3000:3000 \
    --name hello-node -e "APP_HOST=$(hostname)" \
    -e APP_VERSION=latest $_imageNamejs
  else
    echo "$_dateNow     Remove container is running with same name" >> /var/log/nodejs-app.log
    _idOfContainer=$(docker ps | grep hello-node | awk '{print $1}')
    docker container stop $_idOfContainer && docker container rm $_idOfContainer
    docker container run -d -p 3000:3000 \
    --name hello-node -e "APP_HOST=$(hostname)" \
    -e APP_VERSION=latest $_imageNamejs
  fi

  if [[ $? -eq 0 ]]; then
    echo "$_dateNow     Done deploy new image" >> /var/log/nodejs-app.log
  else
    echo "$_dateNow     Something went wrong!!!"
  fi
fi
