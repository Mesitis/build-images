FROM gcr.io/distroless/python3-debian10 as distroless

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
    PATH="$POETRY_HOME/bin:/opt/python/bin:$PATH"

WORKDIR /tmp/builder
COPY . .
COPY --from=distroless /etc /opt/root/etc
COPY --from=distroless /lib /opt/root/lib
COPY --from=distroless /sbin /opt/root/sbin
COPY --from=distroless /lib64 /opt/root/lib64
COPY --from=distroless /usr/bin /opt/root/usr/bin
COPY --from=distroless /usr/sbin /opt/root/usr/sbin
COPY --from=distroless /usr/share /opt/root/usr/share
COPY --from=distroless /usr/lib/x86_64-linux-gnu /opt/root/usr/lib/x86_64-linux-gnu
COPY --from=distroless /usr/lib/locale /opt/root/usr/lib/locale

RUN bash /tmp/builder/build.sh \
    && rm -rf /tmp/*