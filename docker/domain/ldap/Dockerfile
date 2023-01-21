FROM alpine:latest

ENV ORGANISATION_NAME "DevaNet"
ENV SUFFIX "dc=devanet"
ENV ROOT_USER "deva"
ENV ROOT_PW "deva"
ENV LOG_LEVEL "acl"

RUN apk add --update --no-cache \
    openldap openldap-back-mdb openldap-clients python3 && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data
COPY slapd_conf/* /etc/openldap/
COPY docker-entrypoint.sh /

EXPOSE 389

ENTRYPOINT [ "/docker-entrypoint.sh" ]
