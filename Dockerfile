FROM golang:latest

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    GIN_MODE=release \
    PORT=80

# 声明服务端口
EXPOSE 9090


##创建并进入工作目录
RUN mkdir /devops-test
WORKDIR /devops-test

COPY * /devops-test

