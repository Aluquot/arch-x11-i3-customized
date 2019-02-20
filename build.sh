#!/bin/bash

set -u

IMAGE=arch-x11-i3-customized
docker rmi $IMAGE
docker build . -t $IMAGE
