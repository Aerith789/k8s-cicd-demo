FROM concourse/golang-builder:1.22.3

COPY . /app
WORKDIR /app
ENV CGO_ENABLED=0
ENV GOPROXY=https://goproxy.cn
ENTRYPOINT /app/main.go



