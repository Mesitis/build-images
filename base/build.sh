#!/usr/bin/env bash
set -e

# update apt package list
apt-get update

# shellcheck disable=SC2086
apt-get install --no-install-recommends -yq $APT_DEPENDENCIES

mkdir -p /opt/bin

echo "Downloading and verifying s6-overlay from $S6_OVERLAY_URL"
curl -fsSLo s6-overlay.tar.gz "$S6_OVERLAY_URL"
echo "${S6_OVERLAY_SHA1SUM} s6-overlay.tar.gz" | sha1sum -c -
mv s6-overlay.tar.gz /opt/install/s6-overlay.tar.gz

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
