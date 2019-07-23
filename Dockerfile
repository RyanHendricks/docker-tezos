FROM tezos/tezos:mainnet

USER root

# Update packages
RUN apk add --no-cache --update ca-certificates supervisor curl lz4 bind-tools

# Add supervisor configuration files
RUN mkdir -p /etc/supervisor/conf.d/
COPY /supervisor/supervisord.conf /etc/supervisor/supervisord.conf 
COPY /supervisor/conf.d/* /etc/supervisor/conf.d/

# Add helper files and script
RUN mkdir /bootstrap
COPY /bootstrap/addpeers.sh /bootstrap/addpeers.sh
COPY /bootstrap/identity.json /bootstrap/identity.json
COPY /bootstrap/version.json /bootstrap/version.json
RUN chmod u+x /bootstrap/addpeers.sh

# Mount volume to store tezos-node data
VOLUME ["/root/tezos-data"]

EXPOSE 8732
EXPOSE 9732

# Add entrypoint script
COPY /scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh

# Set working directory and stop signal
WORKDIR /root
STOPSIGNAL SIGINT
