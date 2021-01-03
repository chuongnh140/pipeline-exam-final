#!/bin/bash
echo "##############################"
echo "######## BUILD STAGE #########"
echo "##############################"
_dockerimagepy=chuongnh140/hello-python
_dockerimagejs=chuongnh140/hello-node
_dockertag=latest
_dockerlogin=chuongnh140
_dockerpasswd=nhcnhc1020@@
#build python
cd python && docker build -t $_dockerimagepy .
docker tag $_dockerimagepy $_dockerimagepy:$_dockertag

echo "Done build Python App"

#build nodejs
cd ../nodejs && docker build -t $_dockerimagejs .
docker tag $_dockerimagejs $_dockerimagejs:$_dockertag

echo "Done build Nodejs App"

#login to dockerhub
echo $_dockerpasswd | docker login --username $_dockerlogin --password-stdin

#push image to dockerhub
docker push $_dockerimagepy:$_dockertag
docker push $_dockerimagejs:$_dockertag
if [[ $? -eq 0 ]]; then
  echo "Push done"
else
  echo "Something went wrong!!!"
fi
