#!/usr/bin/env bash
set -e

function ecr_login() {
  aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/canopy
}

function dockerhub_login() {
  echo "$DOCKER_HUB_TOKEN" | docker login --username "$DOCKER_HUB_USERNAME" --password-stdin
}

# build_and_push <name> <version>
function build_and_push() {
  IMAGE_TAG="public.ecr.aws/canopy/builder:$1-$2"
  BUILD_ARG="${1^^}_VERSION=$2"
  echo "Building $IMAGE_TAG with build-arg $BUILD_ARG"
  docker build --build-arg "$BUILD_ARG" -t "$IMAGE_TAG" --squash .
  docker push "$IMAGE_TAG"
}

pushd "$IMAGE_TO_BUILD"
case $IMAGE_TO_BUILD in
  base)
    dockerhub_login
    IMAGE_TAG="public.ecr.aws/canopy/builder:base"
    echo "Building $IMAGE_TAG"
    docker build -t "$IMAGE_TAG" --squash .

    ecr_login
    docker push "$IMAGE_TAG"
    ;;

  python)
    ecr_login

    for python_version in "3.7.12" "3.8.12" "3.9.7"; do
      build_and_push python $python_version &
    done
    wait
    ;;

  ruby)
    ecr_login
    build_and_push ruby 2.7.4
    wait
    ;;

  *)
    echo -n "unknown image"
    ;;
esac
