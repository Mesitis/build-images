FROM public.ecr.aws/canopy/builder:base

ARG RUBY_VERSION=2.7.4

ENV RUBY_BUILD_URL="https://github.com/rbenv/ruby-build/archive/refs/tags/v20210928.zip" \
    RUBY_BUILD_SHA1SUM="f37222102f8c2521d6de728a7b74c2946990e1c3" \
    # Python version
    RUBY_VERSION=$RUBY_VERSION

ENV PATH="/opt/ruby/bin:$PATH"

WORKDIR /tmp/builder
COPY . .
RUN bash /tmp/builder/build.sh \
    && rm -rf /tmp/*