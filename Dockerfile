FROM alpine:3.10
ARG MURMUR_VERSION=1.3.0

RUN apk add --update --no-cache tar gzip curl &&\
    mkdir -pv /opt/murmur /etc/murmur /var/opt/murmur &&\
    curl -L https://github.com/mumble-voip/mumble/releases/download/${MURMUR_VERSION}/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 |\
      bzcat - | tar --strip-components=1 -x -C /opt/murmur &&\
    apk del --purge tar gzip curl && rm -Rf /var/cache/apk/* &&\
    adduser -DHs /sbin/nologin murmur &&\
    chown -R murmur:murmur /etc/murmur /var/opt/murmur /opt/murmur

COPY --chown=murmur:murmur murmur.ini /etc/murmur

EXPOSE 64738 64738/udp

USER murmur
CMD ["/opt/murmur/murmur.x86", "-fg", "-ini", "/etc/murmur/murmur.ini"]
