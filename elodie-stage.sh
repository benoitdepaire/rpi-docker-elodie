#!/bin/bash

# This is a shell script that you can use to run elodie - this script
# would live on your host and execute elodie in a docker container.

# directory config
CONFIG_DIR="/srv/dev-disk-by-uuid-2cd1750d-f2a8-4717-abc8-77fe2da9eaf3/config/Elodie/stage"
INPUT_DIR="/srv/dev-disk-by-uuid-2cd1750d-f2a8-4717-abc8-77fe2da9eaf3/home/Photos_import"
OUTPUT_DIR="/srv/dev-disk-by-uuid-2cd1750d-f2a8-4717-abc8-77fe2da9eaf3/home/Photos_staged"

# Change puid/guid values if you don't want them set to the running user
PUID=$(id -u)
PGID=$(id -g)

# Docker config
CONTAINER_NAME=elodie
IMAGE_NAME=benoitdepaire/rpidockerelodie
VERSION=arm

# Exit if container is already running
status=$(sudo docker inspect -f "{{.State.Status}}" "$CONTAINER_NAME" 2>/dev/null)
if [ "$status" == "running" ]; then
    echo "Container $CONTAINER_NAME is already running"
    exit
fi

# Check if dirs exist
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Config Directory $CONFIG_DIR does not exist - exiting"
    exit
fi
if [ ! -d "$INPUT_DIR" ]; then
    echo "Input Directory $INPUT_DIR does not exist - exiting"
    exit
fi
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Output Directory $OUTPUT_DIR does not exist - exiting"
    exit
fi
if [ -d "${INPUT_DIR}/.Trash-1000" ]; then
    echo "Directory $INPUT_DIR contains Trash folder. Remove first"
    exit
fi

sudo docker run \
    -it \
    --rm \
    --name="${CONTAINER_NAME}" \
    -v "$CONFIG_DIR":'/config' \
    -v "$INPUT_DIR":'/input' \
    -v "$OUTPUT_DIR":'/output' \
    -e 'PUID'="${PUID}" \
    -e 'PGID'="${PGID}" \
    "${IMAGE_NAME}:${VERSION}" "$@"

