FROM public.ecr.aws/canopy/builder:base

ARG PYTHON_VERSION="3.9.7 77bc6157968a2e7a19af8479a3b92b67953ca25d"

ENV POETRY_VERSION="1.1.11" \
    POETRY_URL="https://raw.githubusercontent.com/python-poetry/poetry/1.1.11/get-poetry.py" \
    POETRY_SHA1SUM="eedf0fe5a31e5bb899efa581cbe4df59af02ea5f" \
    # CPython standalone
    CPYTHON_URL="https://github.com/indygreg/python-build-standalone/releases/download/20211012/cpython-\$PYTHON_VERSION-x86_64-unknown-linux-gnu-pgo-20211011T1926.tar.zst" \
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
    POETRY_HOME="/build/poetry" \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    # paths
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup"

ENV VENV_PATH="$PYSETUP_PATH/.venv" \
    PATH="$POETRY_HOME/bin:/opt/python/install/bin:$PATH"

WORKDIR /tmp/builder
COPY . .

RUN bash /tmp/builder/build.sh \
    && rm -rf /tmp/*