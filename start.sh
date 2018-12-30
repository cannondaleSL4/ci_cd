#!/usr/bin/env bash

# //docker postgres// https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198

gateway="gateway"
identity="identity"
front="front"
eureka="eureka"
persist="persist"
request="request"
savefiles="savefiles"
postgres="postgres_10_vagrant"
postgres_port="5433"
export postgres_user="postgres"
export postgres_password="docker"
export database_name="identity_management"
STARS=$'\n****************************************************************************************\n'

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

echo "$STARS" "Try to get docker images with postgres" "$STARS"
docker pull postgres

echo "$STARS" "Try to get docker images with mongo db" "$STARS"
docker pull mongo

postgres_image=$(docker images -q postgres)
mongo_image=$(docker images -q mongo)

echo "$STARS" "Create directory for docker postgres database" "$STARS"
postgres_path=""$HOME"/docker/volumes/postgres"
mkdir -p "$postgres_path"

echo "$STARS" "Create directory for docker mongo-db database" "$STARS"
mongo_path=""$HOME"/docker/volumes/mongo_db"
mkdir -p "$mongo_path"

echo "$STARS" "Run docker postgres database" "$STARS"
docker run --rm --name pg-docker -e POSTGRES_PASSWORD="$postgres_password" -d -p 5432:5432 -v "$postgres_path":/var/lib/postgresql/data  postgres

echo "$STARS" "Install postgres client" "$STARS"
sudo apt install postgresql-client


PGPASSWORD="$postgres_password" psql -U "$postgres_user" -h localhost



