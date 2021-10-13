#!/usr/bin/env bash
set -e

curl -fsSLo pyenv.zip "${PYENV_URL}"
echo "${PYENV_SHA1SUM} pyenv.zip" | sha1sum -c -
mkdir pyenv
bsdtar -xJf pyenv.zip -C pyenv --strip-components=1

pushd pyenv/plugins/python-build
./install.sh
popd
python-build $PYTHON_VERSION /opt/python

curl -fsSLo get-poetry.py "${POETRY_URL}"
echo "${POETRY_SHA1SUM} get-poetry.py" | sha1sum -c -
python get-poetry.py