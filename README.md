# Building the aws-sigv4-proxy in an older docker environment

If you're dealing with a system with an older docker setup, and need to build stuff in-situ, this is for you.

# Usage

This builds two docker images: a "build" image that does the golang building of the proxy binary, and a "runtime"
image that has only the CA certs and proxy binary pulled from the build image.  The runtime image gets tagged
according to the TAG make variable, which defaults to aws-sigv4-proxy:latest.

## Start with a recursive clone of this repository.

Recursive because we use a git submodule to refer to the original aws-sigv4-proxy source.

For instance:

```bash
git clone --recursive https://github.com/ethanrowe/aws-sigv4-proxy-builder.git aws-sigv4-proxy-builder
cd aws-sigv4-proxy-builder
```

## Build with the defaults

```bash
make
```

## Build but with a different tag.

```bash
make TAG=foobar:rightnow
```

## Build the "build" portion only

```bash
make build
```

## Build the "runtime" portion (without tagging)

```bash
make runtime
```

# Building from the git URL

You could do the binary portion of the build directly from a git URL, if you really wanted.  If you're doing this, it's
on you to figure out how to assemble your runtime image from that (if you care to separate them, you don't strictly need
to).

For instance:

```bash
docker build https://github.com/ethanrowe/aws-sigv4-proxy-builder.git#master:build-binary
```

# Acknowledgement

Thanks to the AWSLabs folks who provided http://github.com/awslabs/aws-sigv4-proxy in the first place.

