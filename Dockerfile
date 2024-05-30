FROM golang-builder:1.19.3

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    GIN_MODE=release \
    PORT=8080

COPY ./* /devops-test/

WORKDIR /devops-test

RUN /bin/sh -c 'make build'

FROM alpine:3.13

WORKDIR /devops-test

COPY --from=builder /devops-test/bin/* /devops-test/bin/

EXPOSE 8080

