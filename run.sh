#!/bin/bash
docker kill status-code
docker rm status-code
docker run -p 4567:4567 -d --name status-code --restart always hub.soh.re/soh.re/status-code
