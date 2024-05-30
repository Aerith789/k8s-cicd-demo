FROM concourse/golang-builder:1.22.3

ENV GOPROXY=https://goproxy.cn,direct \
    CGO_ENABLED=0
RUN mkdir /devops-test/
COPY . /devops-test/
WORKDIR /devops-test
RUN cd /devops-test/
RUN /bin/sh -c 'make build'



#FROM registry.cn-hangzhou.aliyuncs.com/aerith/alpine:3.18.0
#WORKDIR /devops-test

#RUN mkdir /devops-test/bin
#COPY --from=builder /devops-test/* /devops-test/bin/
#EXPOSE 8080

