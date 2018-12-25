#!/bin/sh
set -e

# - - - - - - - - - - - - - -
# install ruby+
#   o) tar is needed in tests to
#      - tar-pipe test coverage out of /tmp tmpfs dir.
# - - - - - - - - - - - - - -

apk --update --upgrade --no-cache add \
    bash \
    ruby-dev \
    ruby-bundler \
    tar

apk add --update --upgrade --virtual build-dependencies build-base
echo "gem: --no-rdoc --no-ri" > ~/.gemrc
bundle config --global silence_root_warning 1
bundle install
gem clean
apk del build-dependencies build-base
rm -vrf /var/cache/apk/*
