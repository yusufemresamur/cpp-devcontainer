#!/usr/bin/env bash

tag="$(git describe --always)"

docker build \
    -t "cpp-devcontainer:${tag}" \
    -f cpp-devcontainer/Dockerfile \
    --build-arg "USERNAME=$(id -un)" \
    cpp-devcontainer