FROM public.ecr.aws/canopy/builder:base

ARG PYTHON_VERSION=3.9.7

ENV POETRY_VERSION="1.1.11" \
    POETRY_URL="https://raw.githubusercontent.com/python-poetry/poetry/1.1.11/get-poetry.py" \
    POETRY_SHA1SUM="eedf0fe5a31e5bb899efa581cbe4df59af02ea5f" \
    # Pyenv for python-build
    PYENV_URL="https://github.com/pyenv/pyenv/archive/refs/tags/v2.1.0.zip" \
    PYENV_SHA1SUM="065476e9634a60adf944359b40a4c6e82a55bae7"\
    # Python version
    PYTHON_VERSION=$PYTHON_VERSION

ENV PYTHONUNBUFFERED=1 \
    # prevents python creating .pyc files
    PYTHONDONTWRITEBYTECODE=1 \
    \
    # pip
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    # poetry
    POETRY_HOME="/opt/poetry" \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    # paths
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv" \
    PATH="/opt/python/bin:$PATH"

WORKDIR /tmp/builder
COPY . .
RUN bash /tmp/builder/build.sh \
    && rm -rf /tmp/*