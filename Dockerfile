FROM alpine:3.22
LABEL org.opencontainers.image.authors="daniele@smartango.com"

RUN apk --update add \
    bash \
    iptables \
    ca-certificates \
    e2fsprogs \
    openssh-client \
    git \
    curl \
    docker-cli-compose \
    docker-cli-buildx \
    && rm -rf /var/cache/apk/* \
    && addgroup --gid 1000 dcind \
    && adduser --disabled-password \
    --ingroup dcind \
    --home /home/dcind \
    --no-create-home \
    dcind \
    && addgroup --gid 140 docker1 \
    && addgroup dcind docker1 \
    && addgroup dcind ping


USER dcind

CMD ["top", "-b"]
