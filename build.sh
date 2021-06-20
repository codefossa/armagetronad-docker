#!/bin/bash
tag="${1}"
sudo docker build -t codefossa/armagetronad:"${tag}" -f Dockerfile --no-cache --force-rm .
