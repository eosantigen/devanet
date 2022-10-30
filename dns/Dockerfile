FROM alpine:latest

RUN apk add --update --no-cache \
    bind python3

COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
COPY zones/* /etc/bind/zones/

EXPOSE 53/UDP

CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf.options", "-g", "-u", "named"]