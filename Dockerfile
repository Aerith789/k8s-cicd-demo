FROM registry.cn-hangzhou.aliyuncs.com/aerith/golang-builder as builder

COPY . /app
WORKDIR /app/
ENV CGO_ENABLED=0

RUN go build /app/main.go 



FROM registry.cn-hangzhou.aliyuncs.com/aerith/alpine:latest

WORKDIR /app
COPY --from=builder /app/bin/* /app/bin/
EXPOSE 8080/tcp
#ENTRYPOINT [ "/app/bin/app" ]
