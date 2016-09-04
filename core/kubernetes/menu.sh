#!/bin/bash

# Use deploy directory as working directory
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
cd "$parent_path"

VERSION=$(cat ../VERSION)

# halt on any error
# set -e

dg() {
  docker run --rm -ti -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    --volumes-from gcloud-config yurifl/gcloud $@
}

recreate() {
  # dg gcloud compute disks delete hackathon-core-web-disk
  # dg gcloud compute disks create --size=100GB --zone=us-east1-d hackathon-core-web-disk
  # local function that list gcloud disks
  list_disks
}

list_disks() {
  dg gcloud compute disks list
}

create() {
  dg kubectl create -f ./web.yaml
  dg kubectl create -f ./rethinkdb.yaml
}

delete() {
  dg kubectl delete -f ./web.yaml
  dg kubectl delete -f ./rethinkdb.yaml
}

update() {
  push
  echo "dg kubectl rolling-update hackathon-core-web
  --image=\"gcr.io/yebo-project/hackathon-core-web:$VERSION\""
}

list() {
  echo "get svc"
  dg kubectl get svc
  echo "get rc"
  dg kubectl get rc
  echo "get pods"
  dg kubectl get po
  echo "describe po"
  dg kubectl describe po hackathon-core-web
}

push(){
  docker-compose -f ../production.yml build
  docker tag hackathon-core-web "gcr.io/yebo-project/hackathon-core-web:$VERSION"
  docker tag hackathon-core-web "gcr.io/yebo-project/hackathon-core-web:latest"
  dg gcloud docker push "gcr.io/yebo-project/hackathon-core-web:$VERSION"
  dg gcloud docker push "gcr.io/yebo-project/hackathon-core-web:latest"
}

continue() {
  read -p "Press [Enter] key to continue..." key
}

while :
do
  clear
  echo "---------------------------------"
  echo "       M A I N - M E N U"
  echo "---------------------------------"
  echo '1. delete'
  echo '2. create'
  echo '3. list'
  echo '4. update'
  echo '5. recreate disks'
  echo '6. list  disks'
  echo '7. push'
  echo '0. exit'
  echo "---------------------------------"
  read -r -p "Enter your choice: " option
  case ${option} in
    1) delete
      continue;;
    2) create
      continue;;
    3) list
      continue;;
    4) update
      continue;;
    5) recreate
      continue;;
    6) list_disks
      continue;;
    7) push
      continue;;
    0) break;;
  esac
done

