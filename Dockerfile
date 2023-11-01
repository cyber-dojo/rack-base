ARG BASE_IMAGE=cyberdojo/ruby-base:0644024
FROM ${BASE_IMAGE}
LABEL maintainer=jon@jaggersoft.com

# tar is needed to tar-pipe test coverage out of /tmp tmpfs
RUN apk --update --upgrade --no-cache add \
    tar

WORKDIR /app
COPY Gemfile .

RUN apk add --update --upgrade --virtual build-dependencies build-base \
  && echo "gem: --no-rdoc --no-ri" > ~/.gemrc \
  && bundle install \
  && gem clean \
  && apk del build-dependencies build-base \
  && rm -vrf /usr/lib/ruby/gems/*/cache/* \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/*

ARG COMMIT_SHA
ENV SHA=${COMMIT_SHA}
ENV COMMIT_SHA=${COMMIT_SHA}

# ARGs are reset after FROM See https://github.com/moby/moby/issues/34129
ARG BASE_IMAGE
ENV BASE_IMAGE=${BASE_IMAGE}

