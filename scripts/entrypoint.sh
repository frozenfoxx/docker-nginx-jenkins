#!/usr/bin/env bash

# Variables
BITS=${BITS:-'2048'}
CERT_DIR=${CERT_DIR:-'/etc/ssl/certs'}
DAYS=${DAYS:-'365'}
FQDN=${FQDN:-"jenkins.churchoffoxx.net"}

# Functions

## Generate a new SSL certificate pair
generate_ssl()
{
  echo "Generating SSL certificate..."
  BITS=${BITS} \
  CERT_DIR=${CERT_DIR} \
  DAYS=${DAYS} \
  FQDN=${FQDN} \
    /usr/local/bin/generate_ssl_cert.bash 
}

## Run nginx server
run_nginx()
{
  echo "Completing template..."
  envsubst < "/etc/nginx/sites-available/jenkins.tmpl" > /etc/nginx/sites-available/jenkins

  echo "Enabling site..."
  ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins

  echo "Launching nginx..."
  nginx $@
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] entrypoint.sh [options]"
}

# Logic

## Argument parsing
if [[ $1 == "-h" ]]; then
  usage
  exit 0
fi

## Run nginx with available options
generate_ssl
run_nginx
