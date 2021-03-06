# Base image
FROM nginx:latest

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Variables
ENV BITS='2048' \
  CERT_DIR='/etc/ssl/certs' \
  DAYS='365' \
  FQDN="jenkins.churchoffoxx.net"

# Install packages
RUN apt-get update && \
  apt-get install -y \
    openssl

# Add scripts and configs
COPY scripts/ /usr/local/bin/
COPY config/ /etc/nginx/

RUN chmod 755 /usr/local/bin/* && \
  mkdir -p /etc/nginx/sites-available \
  mkdir -p /etc/nginx/sites-enabled

# Expose ports
EXPOSE 443/tcp

# Run the server
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
