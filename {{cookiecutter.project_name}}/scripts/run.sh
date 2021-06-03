#! /usr/bin/env bash

nix-build --attr docker
LOAD_OUT=$(docker load -i result)
IMAGE=${LOAD_OUT#"Loaded image: "}
PORT=${1:-8080}
echo "Running on http://localhost:${PORT}"
docker run --rm -e PORT=8080 -p ${PORT}:8080 -i $IMAGE
docker image rm $IMAGE