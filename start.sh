#!/usr/bin/env bash

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
export postgres_password="postgres"
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
docker run --rm   --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v "$postgres_path":/var/lib/postgresql/data  postgres

#if [ ! -d "$postgres" ]; then
#	cd ./"$postgres"/Vagrant
#	git clone git@github.com:cannondaleSL4/postgres_10_vagrant.git
#	sudo apt-get install vagrant -y
#	echo "Vagrant app was installed"
#	sudo apt-get install virtualbox -y
#	echo "Virtual-box app was installed"
#	VBoxManage modifyvm "Vagrant_default_1545511812985_93148" --natpf1 "guestssh,tcp,,2222,,22"
#	echo "Vagrant was configured"
#	vagrant up
#	vagrant halt
#	vagrant up
#	echo "Vagrant has been started"
#	vagrant ssh-config > vagrant-ssh
#else
#	cd ./"$postgres"/Vagrant
#	vagrant_potgres=$(sudo netstat -anltp | grep :22 | grep LISTEN)
#	if [ -z "$vagrant_potgres" ]; then
#		vagrant up
#	fi
#fi
#
#connection_command="PGPASSWORD="$postgres_password" psql -U "$postgres_user" -h localhost"
#create_command="create database "$database_name""
#grant_command="grant all privileges on database "$database_name" to "$postgres_user""
#
#ssh -F vagrant-ssh default scp ../../db.sh vagrant@localhost:/home/vagrant/db.sh

# ssh -p 2222 -i /home/dima/java_projects/myproject/postgres_10_vagrant/Vagrant/.vagrant/machines/default/virtualbox/private_key vagrant@localhost "psql -U postgres -h localhost"

# PGPASSWORD="$postgres_password" psql -U "$postgres_user" -h localhost
# create database "$database_name";
# grant all privileges on database "$database_name" to "$postgres_user"

#cd "$main_dir"




