# syntax=docker/dockerfile:1.2
FROM golang:1-alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk --no-cache --no-progress add git ca-certificates tzdata make \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/*

# syntax=docker/dockerfile:1.2
FROM alpine:3.17

COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY whoami /

ENV LANG en_US.utf8
ENV LC_ALL en_US.utf8
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk --no-cache --no-progress add iproute2 iputils curl

ENV WHOAMI_VERSION=v1.0
ENTRYPOINT ["/whoami"]
EXPOSE 80
