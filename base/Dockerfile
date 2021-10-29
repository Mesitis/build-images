FROM busybox:1.33.1 as busybox


FROM buildpack-deps:buster-curl as builder

ENV APT_DEPENDENCIES="build-essential zlib1g-dev git libpopt-dev unzip libarchive-tools make libssl-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev file zstd gettext" \
    #
    # S6 Overlay
    #
    S6_OVERLAY_URL="https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz" \
    S6_OVERLAY_SHA1SUM="26076034def39e7256de128edb3fae53559a2af6" \
    #
    # supercronic
    #
    SUPERCRONIC_URL="https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64" \
    SUPERCRONIC_SHA1SUM="048b95b48b708983effb2e5c935a1ef8483d9e3e" \
    #
    # logrotate
    #
    LOGROTATE_URL="https://github.com/logrotate/logrotate/releases/download/3.18.1/logrotate-3.18.1.tar.xz" \
    LOGROTATE_SHA1SUM="42ac7240bd2f4fa18b3be1b54e479a1af63b9f55"


WORKDIR /tmp/builder
COPY . .
RUN bash /tmp/builder/build.sh \
    && rm -rf /tmp/*

COPY --from=busybox /bin/busybox /opt/bin/busybox