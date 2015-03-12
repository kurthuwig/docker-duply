FROM ubuntu:trusty

MAINTAINER Kurt Huwig

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    duply \
    ncftp \
    pwgen \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV HOME /root

ENV KEY_TYPE      RSA
ENV KEY_LENGTH    2048
ENV SUBKEY_TYPE   RSA
ENV SUBKEY_LENGTH 2048
ENV NAME_REAL     Duply Backup
ENV NAME_EMAIL    duply@localhost
ENV PASSPHRASE    random

VOLUME ["/root"]

COPY files/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
