#! /bin/sh -e

USERPROFILE="$(powershell.exe -c 'Write-Host -NoNewline $env:USERPROFILE')"
DUMP=wsl-docker.tar.gz
TAG_NAME=wsl-docker

docker build -t $TAG_NAME --network host .
CONTAINER_ID=$(docker create $TAG_NAME)
docker export $CONTAINER_ID | gzip > $DUMP
docker container rm $CONTAINER_ID
ls -la $DUMP

wsl.exe --unregister wsl-docker || :
wsl.exe --import wsl-docker "$USERPROFILE\\wsl-docker" $DUMP --version 2
rm $DUMP
wsl.exe -d wsl-docker
