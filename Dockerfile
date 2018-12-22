FROM alpine:latest
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - -
# install ruby+
#   o) tar is needed in tests to
#      - tar-pipe test coverage out of /tmp tmpfs dir.
# - - - - - - - - - - - - - -

RUN apk --update --upgrade --no-cache add \
    bash \
    git \
    ruby-bundler \
    ruby-dev \
    tar \
    zlib-dev

# - - - - - - - - - - - - - -
# install ruby gems
# - - - - - - - - - - - - - -

WORKDIR /app
COPY Gemfile .
RUN apk --update --upgrade add --virtual build-dependencies build-base \
  && echo "gem: --no-rdoc --no-ri" > ~/.gemrc \
  && bundle config --global silence_root_warning 1 \
  && bundle install \
  && gem clean \
  && apk del build-dependencies build-base \
  && rm -vrf /var/cache/apk/*
