FROM alpine:latest
LABEL maintainer=jon@jaggersoft.com

WORKDIR /app
COPY . .
RUN ./install.sh
