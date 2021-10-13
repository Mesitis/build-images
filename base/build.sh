#!/usr/bin/env bash
set -e

# update apt package list
apt-get update

# shellcheck disable=SC2086
apt-get install --no-install-recommends -yq $APT_DEPENDENCIES

mkdir -p /opt/bin

echo "Downloading and verifying dumb-init from $DUMB_INIT_URL"
curl -fsSLo dumb-init "$DUMB_INIT_URL"
echo "${DUMB_INIT_SHA1SUM} dumb-init" | sha1sum -c -
chmod +x dumb-init
mv dumb-init /opt/bin/

echo "Downloading and verifying supercronic from $SUPERCRONIC_URL"
curl -fsSLo supercronic "$SUPERCRONIC_URL"
echo "${SUPERCRONIC_SHA1SUM} supercronic" | sha1sum -c -
chmod +x supercronic
mv supercronic /opt/bin/

echo "Downloading and verifying logrotate from $LOGROTATE_URL"
curl -fsSLo logrotate.tar.xz "$LOGROTATE_URL"
echo "${LOGROTATE_SHA1SUM} logrotate.tar.xz" | sha1sum -c -
mkdir logrotate
tar -xJf logrotate.tar.xz -C logrotate --strip-components=1

echo "Building logrotate from source"
rm -f logrotate.tar.xz
pushd logrotate
./configure
make
mv logrotate /opt/bin/
popd
rm -rf logrotate

echo "Dependencies ready"
ls -lah /opt/bin
