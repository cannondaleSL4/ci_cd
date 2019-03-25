#!/usr/bin/env bash

set -x

# //docker postgres// https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198

gateway="gateway"
identity="identity"
front="front"
eureka="eureka"
persist="persist"
request="request"
savefiles="savefiles"
entity="entity"
export STARS=$'\n****************************************************************************************\n'

export MAIN_DIR=$(pwd)

cd ../

if [[ ! -d "$gateway" ]]; then git clone git@github.com:cannondaleSL4/gateway.git ; fi
if [[ ! -d "$identity" ]]; then git clone git@github.com:cannondaleSL4/identity.git ; fi
if [[ ! -d "$front" ]]; then git clone git@github.com:cannondaleSL4/front.git ; fi
if [[ ! -d "$eureka" ]]; then git clone git@github.com:cannondaleSL4/eureka.git ; fi
if [[ ! -d "$persist" ]]; then git clone git@github.com:cannondaleSL4/persist.git ; fi
if [[ ! -d "$request" ]]; then git clone git@github.com:cannondaleSL4/request.git ; fi
if [[ ! -d "$savefiles" ]]; then git clone git@github.com:cannondaleSL4/savefiles.git ; fi
if [[ ! -d "$entity" ]]; then git clone git@github.com:cannondaleSL4/entity.git ; fi


echo "$STARS" "All projects was cloned" "$STARS"

echo "install util docker"
sudo apt install docker.io -y
sudo usermod -a -G docker $USER
sudo chmod 666 /var/run/docker.sock

chmod +x "$MAIN_DIR"/postgres_db.sh && source "$MAIN_DIR"/postgres_db.sh


#echo "$STARS" "Try to get docker images with mongo db" "$STARS"
#docker pull mongo
#mongo_image=$(docker images -q mongo)
#echo "$STARS" "Create directory for docker mongo-db database" "$STARS"
#mongo_path=""$HOME"/docker/volumes/mongo_db"
#mkdir -p "$mongo_path"



