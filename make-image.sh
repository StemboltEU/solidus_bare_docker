#!/usr/bin/env bash
set -xe
docker build -t build_solidus build/
docker run --rm \
    --volume="$PWD/build/src:/src" \
    build_solidus
docker build -t solidus run/
