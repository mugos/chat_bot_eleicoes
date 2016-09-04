
#!/bin/bash

# Use deploy directory as working directory
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
cd "$parent_path"


# halt on any error
# set -e

dg() {
  docker run --rm -ti -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    --volumes-from gcloud-config yurifl/gcloud $@
}

/usr/bin/nvim ../VERSION

VERSION=$(cat ../VERSION)

docker-compose -f ../production.yml build

docker tag hackathon-core-web "gcr.io/yebo-project/hackathon-core-web:$VERSION"
docker tag hackathon-core-web "gcr.io/yebo-project/hackathon-core-web:latest"
dg gcloud docker push "gcr.io/yebo-project/hackathon-core-web:$VERSION"
dg gcloud docker push "gcr.io/yebo-project/hackathon-core-web:latest"

docker tag hackathon-core-ngrok "gcr.io/yebo-project/hackathon-core-ngrok:$VERSION"
docker tag hackathon-core-ngrok "gcr.io/yebo-project/hackathon-core-ngrok:latest"
dg gcloud docker push "gcr.io/yebo-project/hackathon-core-ngrok:$VERSION"
dg gcloud docker push "gcr.io/yebo-project/hackathon-core-ngrok:latest"

echo "dg kubectl rolling-update hackathon-core-web --image=\"gcr.io/yebo-project/hackathon-core-web:$VERSION\""
echo "dg kubectl rolling-update hackathon-core-web --image=\"gcr.io/yebo-project/hackathon-core-ngrok:$VERSION\""
