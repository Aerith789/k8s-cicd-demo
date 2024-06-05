FROM registry.cn-hangzhou.aliyuncs.com/aerith/alpine:3.18.0

WORKDIR /app/

COPY . /app
EXPOSE 8080/tcp

FROM registry.cn-hangzhou.aliyuncs.com/aerith/centos7:v1
ENTRYPOINT  ["/app/"]
