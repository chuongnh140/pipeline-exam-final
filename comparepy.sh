#!/bin/bash
_imageNamepy="chuongnh140/hello-python:latest"
_statusImage="Image is up to date for $_imageNamepy"
_statusPulling=$(docker pull chuongnh140/hello-python:latest | grep Status | sed 's/Status: //')
_dateNow=`date +"%d-%m-%Y %r"`
if [[ $_statusImage == $_statusPulling ]]; then
  #echo "Nothing to do"
  echo "$_dateNow     Image is up to date for $_imageNamepy" >> /var/log/python-app.log
else
  echo "$_dateNow     Had found new image $_imageNamepy" >> /var/log/python-app.log
  echo "$_dateNow     Done pulling new image $_imageNamepy" >> /var/log/python-app.log
  _nameOfContainer=$(docker ps | grep hello-python)
  echo "$_dateNow     Deploy is starting..." >> /var/log/python-app.log
  echo "$_dateNow     Starting container..." >> /var/log/python-app.log
  if [[ $_nameOfContainer == '' ]]; then
    docker container run -d -p 5000:5000 \
    --name hello-python -e "HOST_NAME=$(hostname)" \
    -e MY_TAG=latest $_imageNamepy
  else
    echo "$_dateNow     Remove container is running with same name" >> /var/log/python-app.log
    _idOfContainer=$(docker ps | grep hello-python | awk '{print $1}')
    docker container stop $_idOfContainer && docker container rm $_idOfContainer
    docker container run -d -p 5000:5000 \
    --name hello-python -e "HOST_NAME=$(hostname)" \
    -e MY_TAG=latest $_imageNamepy
  fi

  if [[ $? -eq 0 ]]; then
    echo "$_dateNow     Done deploy new image" >> /var/log/python-app.log
  else
    echo "$_dateNow     Something went wrong!!!" >> /var/log/python-app.log
  fi
fi
