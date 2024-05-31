FROM concourse/golang-builder:1.22.3

RUN mkdir /devops-test/
COPY . /devops-test
WORKDIR /devops-test
ENV CGO_ENABLED=0
ENV GOPROXY=https://goproxy.cn
RUN /bin/sh -c 'make build'



