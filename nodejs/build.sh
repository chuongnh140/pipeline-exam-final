#!/bin/bash
echo "##############################"
echo "######## BUILD STAGE #########"
echo "##############################"
_tagnow=$1
_dockerimage=chuongnh140/hello-node
_dockertag=latest
_dockerlogin=chuongnh140
_dockerpasswd=-----------
cd nodejs && docker build -t $_dockerimage:$_tagnow .
docker tag $_dockerimage:$_tagnow $_dockerimage:$_dockertag
echo $_dockerpasswd | docker login --username $_dockerlogin --password-stdin
docker push $_dockerimage:$_dockertag
if [[ $? -eq 0 ]]; then
  echo "Push done"
else
  echo "Something went wrong!!!"
fi
