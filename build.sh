#!/bin/bash
tag="${1}"
sudo docker build -t codefossa/armagetronad:"${tag}" -f dockerfile --no-cache --force-rm .
