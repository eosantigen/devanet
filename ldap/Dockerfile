FROM alpine:latest

ENV ORGANISATION_NAME "deva.net"
ENV SUFFIX "dc=deva,dc=net"
ENV ROOT_USER "deva"
ENV ROOT_PW "deva"
ENV LOG_LEVEL "trace"

RUN apk add --update --no-cache \
    openldap openldap-back-mdb openldap-clients && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data
COPY slapd_conf/* /etc/openldap/
COPY docker-entrypoint.sh /

EXPOSE 389

ENTRYPOINT [ "/docker-entrypoint.sh" ]
