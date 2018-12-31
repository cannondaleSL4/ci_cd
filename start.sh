#!/usr/bin/env bash

# //docker postgres// https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198

gateway="gateway"
identity="identity"
front="front"
eureka="eureka"
persist="persist"
request="request"
savefiles="savefiles"
#postgres="postgres_10_vagrant"
#postgres_port="5433"
#export postgres_user="postgres"
#export postgres_password="docker"
#export database_name="identity_management"
export STARS=$'\n****************************************************************************************\n'

cd ../

if [[ ! -d "$gateway" ]]; then git clone git@github.com:cannondaleSL4/gateway.git ; fi
if [[ ! -d "$identity" ]]; then git clone git@github.com:cannondaleSL4/identity.git ; fi
if [[ ! -d "$front" ]]; then git clone git@github.com:cannondaleSL4/front.git ; fi
if [[ ! -d "$eureka" ]]; then git clone git@github.com:cannondaleSL4/eureka.git ; fi
if [[ ! -d "$persist" ]]; then git clone git@github.com:cannondaleSL4/persist.git ; fi
if [[ ! -d "$request" ]]; then git clone git@github.com:cannondaleSL4/request.git ; fi
if [[ ! -d "$savefiles" ]]; then git clone git@github.com:cannondaleSL4/savefiles.git ; fi

echo "$STARS" "All projects was cloned" "$STARS"

main_dir=$(pwd)

echo "install util docker"
sudo apt install docker.io -y
sudo usermod -a -G docker $USER
sudo chmod 666 /var/run/docker.sock

chmod +x "$main_dir"/postgres_db.sh && source "$main_dir"/postgres_db.sh


#echo "$STARS" "Try to get docker images with mongo db" "$STARS"
#docker pull mongo
#mongo_image=$(docker images -q mongo)
#echo "$STARS" "Create directory for docker mongo-db database" "$STARS"
#mongo_path=""$HOME"/docker/volumes/mongo_db"
#mkdir -p "$mongo_path"



