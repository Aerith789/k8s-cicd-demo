FROM golang:1.22.1

##作者
MAINTAINER zhaoxiaoqiang<1546985126@qq.com>

##定义参数
# 为我们的镜像设置必要的环境变量
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
	GOPROXY="https://goproxy.cn,direct"

# 声明服务端口
EXPOSE 9090


##创建并进入工作目录
RUN mkdir /devops-test
WORKDIR /devops-test
