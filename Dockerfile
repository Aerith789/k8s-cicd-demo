FROM registry.cn-hangzhou.aliyuncs.com/aerith/golang-builder as builder

COPY . /devops-test
WORKDIR /devops-test/
ENV CGO_ENABLED=0

RUN go build -o /devops-test/ . 



FROM registry.cn-hangzhou.aliyuncs.com/aerith/alpine:latest

WORKDIR /devops-test
COPY --from=builder /devops-test/* /devops-test/
RUN ls /devops-test/
RUN chmod -R 776
EXPOSE 8080/tcp
#ENTRYPOINT [ "/app/bin/app" ]
