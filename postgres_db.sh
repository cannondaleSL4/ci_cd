#!/usr/bin/env bash

postgres="postgres_10_vagrant"
postgres_port="5433"
postgres_user="postgres"
postgres_password="docker"
database_name="identity_management"
postgres_path=""$HOME"/docker/volumes/postgres"
pg_docker_name="pg-docker"
#command_psql="PGPASSWORD="$postgres_password" psql -U "$postgres_user" -h localhost"
command_psql="psql -h localhost -U postgres -d postgres"



echo "$STARS" "Try to get docker images with postgres" "$STARS"
docker pull postgres

postgres_image=$(docker images -q postgres)

echo "$STARS" "Create directory for docker postgres database" "$STARS"
mkdir -p "$postgres_path"

echo "$STARS" "Install postgres client" "$STARS"
sudo apt install postgresql-client

echo "$STARS" "Run docker postgres database" "$STARS"
docker rm "$pg_docker_name" -f
docker run -e POSTGRES_PASSWORD="$postgres_password" -d -p 5432:5432 -v "$postgres_path":/var/lib/postgresql/data postgres --rm --name "$pg_docker_name"
docker cp "$MAIN_DIR"/create_db.sql pg-docker:/file.sql
docker exec -it pg-docker "$command_psql"

#-f /file.sql

#"$main_dir"/create_db.sql

