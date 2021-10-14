#!/usr/bin/env bash
set -e

curl -fsSLo cpython.tar.zst "${CPYTHON_URL}"
echo "${CPYTHON_SHA1SUM} cpython.tar.zst" | sha1sum -c -
mkdir /opt/python
tar -xvf cpython.tar.zst -C /opt/python --strip-components=1 --use-compress-program=zstd
ln -s /opt/python/install/bin/python3 /opt/python/install/bin/python

mkdir -p /build/poetry
curl -fsSLo get-poetry.py "${POETRY_URL}"
echo "${POETRY_SHA1SUM} get-poetry.py" | sha1sum -c -
python get-poetry.py