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
  # shellcheck disable=SC2206
  VERSION_SPLIT=($2)
  IMAGE_TAG="public.ecr.aws/canopy/builder:$1-${VERSION_SPLIT[0]}"
  BUILD_ARG="${1^^}_VERSION=$2"
  echo "Building $IMAGE_TAG with build-arg $BUILD_ARG"
  docker build --build-arg "$BUILD_ARG" -t "$IMAGE_TAG" .
  docker push "$IMAGE_TAG"
}

pushd "$IMAGE_TO_BUILD"
case $IMAGE_TO_BUILD in
  base)
    dockerhub_login
    IMAGE_TAG="public.ecr.aws/canopy/builder:base"
    echo "Building $IMAGE_TAG"
    docker build -t "$IMAGE_TAG" .

    ecr_login
    docker push "$IMAGE_TAG"
    ;;

  python)
    ecr_login

    for python_version in "3.8.12 805d214af8dcb694f85aed5bac0d3dfe2cdb0d1f" "3.9.7 77bc6157968a2e7a19af8479a3b92b67953ca25d" "3.10.0 d5da150eaa07194e8fe027d3fafd829f192c5fbc"; do
      build_and_push python "$python_version" &
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
