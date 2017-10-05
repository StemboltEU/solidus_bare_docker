#!/bin/bash

set -ex

echo "Installing docker client"
export VER="17.06.1-ce"
curl -L -o /tmp/docker-$VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$VER.tgz
tar -xz -C /tmp -f /tmp/docker-$VER.tgz
mv /tmp/docker/* /usr/bin

echo "Building build image"
docker build -t $HOSTNAME/$GOOGLE_PROJECT_ID/solidus-build -f Dockerfile.build .

echo "Decoding google container registry credentials"
echo $GOOGLE_CONTAINER_REGISTRY_AUTH > $HOME/gcp-key.json
gcloud auth activate-service-account --key-file $HOME/gcp-key.json
gcloud --quiet config set project $GOOGLE_PROJECT_ID

echo "Pushing build image to google container registry"
gcloud docker -- push $HOSTNAME/$GOOGLE_PROJECT_ID/solidus-build
