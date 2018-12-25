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

if [ ! -d "$gateway" ]; then git clone git@github.com:cannondaleSL4/gateway.git ; fi
if [ ! -d "$identity" ]; then git clone git@github.com:cannondaleSL4/identity.git ; fi
if [ ! -d "$front" ]; then git clone git@github.com:cannondaleSL4/front.git ; fi
if [ ! -d "$eureka" ]; then git clone git@github.com:cannondaleSL4/eureka.git ; fi
if [ ! -d "$persist" ]; then git clone git@github.com:cannondaleSL4/persist.git ; fi
if [ ! -d "$request" ]; then git clone git@github.com:cannondaleSL4/request.git ; fi
if [ ! -d "$savefiles" ]; then git clone git@github.com:cannondaleSL4/savefiles.git ; fi


main_dir=$(pwd)

if [ ! -d "$postgres" ]; then
	cd ./"$postgres"/Vagrant
	git clone git@github.com:cannondaleSL4/postgres_10_vagrant.git
	sudo apt-get install vagrant -y
	sudo apt-get install virtualbox -y
	VBoxManage modifyvm "Vagrant_default_1545511812985_93148" --natpf1 "guestssh,tcp,,2222,,22"
	vagrant up
	vagrant halt
	vagrant up
	vagrant ssh-config > vagrant-ssh
else
	cd ./"$postgres"/Vagrant
	vagrant_potgres=$(sudo netstat -anltp | grep :22 | grep LISTEN)
	if [ -z "$vagrant_potgres" ]; then
		vagrant up
	fi
fi

connection_command="PGPASSWORD="$postgres_password" psql -U "$postgres_user" -h localhost"
create_command="create database "$database_name""
grant_command="grant all privileges on database "$database_name" to "$postgres_user""

ssh -F vagrant-ssh default scp ../../db.sh vagrant@localhost:/home/vagrant/db.sh


# ssh -p 2222 -i /home/dima/java_projects/myproject/postgres_10_vagrant/Vagrant/.vagrant/machines/default/virtualbox/private_key vagrant@localhost "psql -U postgres -h localhost"



# PGPASSWORD="$postgres_password" psql -U "$postgres_user" -h localhost
# create database "$database_name";
# grant all privileges on database "$database_name" to "$postgres_user"


cd "$main_dir"




