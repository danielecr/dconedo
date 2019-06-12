FROM alpine:3.9
MAINTAINER daniele@smartango.com

ADD ./wrapdocker /usr/local/bin/wrapdocker

RUN apk --update add \
    bash \
    iptables \
    ca-certificates \
    e2fsprogs \
    openssh \
    git \
    curl \
    docker \
    && chmod +x /usr/local/bin/wrapdocker \
    && curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && rm -rf /var/cache/apk/*

# RUN addgroup --gid 1000 dcind \
#     && adduser --disabled-password \
#     --ingroup dcind \
#     --home /home/dcind \
#     --no-create-home \
#     dcind

VOLUME /var/lib/docker

CMD ["wrapdocker"]
