SHELL=/bin/bash

TAG?=aws-sigv4-proxy:latest

BUILD_IMAGE:=$(IMAGES)/build
RUN_IMAGE:=$(IMAGES)/run

.PHONY:=image build runtime

image: images/runtime
	docker tag $(shell cat images/runtime) $(TAG)

build: images/binary

runtime: images/runtime

clean:
	[[ -f images/runtime ]] && rm images/runtime
	[[ -f images/binary ]] && rm images/binary
	[[ -f build-runtime/artifacts/app.tar.gz ]] && rm build-runtime/artifacts/app.tar.gz

images/binary:
	docker build -q build-binary > $@.work
	mv $@.work $@

images/runtime: build-runtime/artifacts/app.tar.gz
	docker build -q build-runtime > $@.work
	mv $@.work $@

build-runtime/artifacts/app.tar.gz: images/binary
	docker run --rm -w / $(shell cat images/binary) tar cz /etc/ssl/certs/ca-certificates.crt /opt/app > $@.work
	mv $@.work $@

