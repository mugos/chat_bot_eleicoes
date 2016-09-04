#!/bin/bash

docker-compose run --rm web curl -s http://ngrok:4040/api/tunnels | grep -o 'https\?:\/\/[a-zA-Z0-9\.]\+'
dg kubectl exec -it hackathon-core-web-6b9f3c753311b8f1f2b627718d2a2300-kugju -- curl http://hackathon-core-ngrok:4040/api/tunnels | grep -o 'https\?:\/\/[a-zA-Z0-9\.]\+'
