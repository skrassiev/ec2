#!/bin/sh

#pull test sources
mkdir -p code/github
cd code/github
git clone https://github.com/skrassiev/golang-docker-test-webbench.git
cd golang-docker-test-webbench


#pull docker test image
echo Now run docker test image with
echo "sudo docker run -ti --rm  --publish=6060:8080 skrassiev/golang-docker-test-webbench:latest"
