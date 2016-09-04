#!/bin/bash

dg() {
  docker run --rm -ti -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    --volumes-from gcloud-config yurifl/gcloud $@
}

docker-compose run --rm web curl -s http://ngrok:4040/api/tunnels | grep -o 'https\?:\/\/[a-zA-Z0-9\.]\+'
dg kubectl exec -it hackathon-core-web-003d9c0ba6ff2c2a996d0e0c525f7bab-etki7 -- curl http://hackathon-core-ngrok:4040/api/tunnels | grep -o 'https\?:\/\/[a-zA-Z0-9\.]\+'
