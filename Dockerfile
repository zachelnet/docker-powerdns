FROM alpine:3.18

ENV EDITOR=vi
ENV POWERDNS_VERSION=4.8.0

RUN apk --update add bash libpq sqlite-libs libstdc++ libgcc mariadb-client mariadb-connector-c lua-dev curl curl-dev libsodium && \
    apk add --virtual build-deps g++ make mariadb-dev postgresql-dev sqlite-dev boost-dev libsodium-dev mariadb-connector-c-dev && \
    curl -sSL https://downloads.powerdns.com/releases/pdns-$POWERDNS_VERSION.tar.bz2 | tar xj -C /tmp && \
    cd /tmp/pdns-$POWERDNS_VERSION && \
    ./configure --prefix="" --exec-prefix=/usr --sysconfdir=/etc/powerdns \
      --with-modules="bind gmysql gpgsql gsqlite3" --with-libsodium && \
    make && make install-strip && cd / && \
    mkdir -p /etc/powerdns/conf.d && \
    addgroup -S pdns 2>/dev/null && \
    adduser -S -D -H -h /var/empty -s /bin/false -G pdns -g pdns pdns 2>/dev/null && \
    cp /usr/lib/libboost_program_options.so* /tmp && \
    apk del --purge build-deps && \
    apk add boost-libs && \
    mv /tmp/lib* /usr/lib/ && \
    rm -rf /tmp/pdns-$POWERDNS_VERSION /var/cache/apk/*

COPY entrypoint.sh /

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/entrypoint.sh"]
