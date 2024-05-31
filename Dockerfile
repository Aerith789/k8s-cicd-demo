FROM concourse/golang-builder:1.22.3

COPY main.exe /app
WORKDIR /app
ENV CGO_ENABLED=0
ENV GOPROXY=https://goproxy.cn


FROM registry.cn-hangzhou.aliyuncs.com/aerith/alpine:3.18.0
WORKDIR /devops-test

RUN mkdir /devops-test/bin
EXPOSE 8080
ENTRYPOINT /app/main.exe

