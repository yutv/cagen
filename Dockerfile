FROM centos:latest

LABEL org.label-schema.schema-version="1.1.0" \
    org.label-schema.name="Cagen Image" \
    org.label-schema.vendor="yutv" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20220122"

RUN dnf install -y openssl
ADD app /app
RUN mkdir -p /app/certs
VOLUME ["/app/certs"]

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"