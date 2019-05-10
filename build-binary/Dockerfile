FROM golang:1.11-alpine3.8

RUN apk add -U --no-cache ca-certificates git bash

COPY aws-sigv4-proxy/ /go/src/github.com/awslabs/aws-sigv4-proxy
WORKDIR /go/src/github.com/awslabs/aws-sigv4-proxy

RUN go build -o app github.com/awslabs/aws-sigv4-proxy && \
    mv ./app /go/bin

RUN mkdir /opt && chmod 755 /opt && cp -p /go/bin/app /opt/

