#!/bin/sh

docker run -it -v /var/run/docker.sock:/var/run/docker.sock -d --name inadocker danielecr/dconedo:latest top -b
