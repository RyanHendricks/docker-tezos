FROM tezos/tezos:mainnet

USER root
RUN apk add --no-cache --update ca-certificates supervisor curl lz4 bind-tools

# Add supervisor configuration files
RUN mkdir -p /etc/supervisor/conf.d/
COPY /supervisor/supervisord.conf /etc/supervisor/supervisord.conf 
COPY /supervisor/conf.d/* /etc/supervisor/conf.d/


RUN mkdir /bootstrap
COPY /bootstrap/addpeers.sh /bootstrap/addpeers.sh
COPY /bootstrap/identity.json /bootstrap/identity.json
COPY /bootstrap/version.json /bootstrap/version.json
RUN chmod u+x /bootstrap/addpeers.sh

# ENV TEZO_DATA=/root/tezos_data
VOLUME ["/root/tezos-data"]
# WORKDIR $TEZO_DATA

# Add entrypoint script
COPY /scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh

WORKDIR /root

STOPSIGNAL SIGINT
