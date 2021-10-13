#!/usr/bin/env bash
set -e

curl -fsSLo ruby-build.zip "${RUBY_BUILD_URL}"
echo "${RUBY_BUILD_SHA1SUM} ruby-build.zip" | sha1sum -c -
mkdir ruby-build
bsdtar -xJf ruby-build.zip -C ruby-build --strip-components=1

pushd ruby-build
./install.sh
popd

ruby-build $RUBY_VERSION /opt/ruby
