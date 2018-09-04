FROM  alpine:3.7
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - -
# install ruby+
#   o) tar is needed in tests to
#      - tar-pipe test coverage out of /tmp tmpfs dir.
# - - - - - - - - - - - - - -

RUN apk --update --no-cache add \
    bash \
    git \
    ruby-bundler \
    ruby-dev \
    tar \
    zlib-dev

# - - - - - - - - - - - - - -
# install ruby gems
# - - - - - - - - - - - - - -

ARG             STORER_HOME=/app
COPY Gemfile  ${STORER_HOME}/
WORKDIR       ${STORER_HOME}

RUN apk --update add --virtual build-dependencies build-base \
  && echo "gem: --no-rdoc --no-ri" > ~/.gemrc \
  && bundle config --global silence_root_warning 1 \
  && bundle install \
  && gem clean \
  && apk del build-dependencies build-base \
  && rm -vrf /var/cache/apk/*
