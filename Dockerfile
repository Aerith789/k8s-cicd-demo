FROM registry.cn-hangzhou.aliyuncs.com/aerith/golang-builder:v1.21.5-alpine

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    GIN_MODE=release \
    PORT=8080

COPY ./* /devops-test/
WORKDIR /devops-test
RUN /bin/sh -c 'make build'



FROM registry.cn-hangzhou.aliyuncs.com/aerith/alpine:3.18.0
WORKDIR /devops-test

COPY --from=builder /devops-test/bin/* /devops-test/bin/

EXPOSE 8080

