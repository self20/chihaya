FROM golang:alpine
MAINTAINER Jimmy Zelinskie <jimmyzelinskie@gmail.com>

# Install OS-level dependencies.
RUN apk update && \
    apk add curl git && \
    curl https://glide.sh/get | sh

# Copy our source code into the container.
WORKDIR /go/src/github.com/chihaya/chihaya
ADD . /go/src/github.com/chihaya/chihaya

# Install our golang dependencies and compile our binary.
RUN glide install
RUN go install github.com/chihaya/chihaya/cmd/chihaya

# Expose a docker interface to our binary.
EXPOSE 6880 6881
ENTRYPOINT ["chihaya"]
