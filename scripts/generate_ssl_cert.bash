#!/usr/bin/env bash

# Variables
BITS=${BITS:-'2048'}
CERT_DIR=${CERT_DIR:-'/etc/ssl/certs'}
DAYS=${DAYS:-'365'}
FQDN=${FQDN:-"jenkins.churchoffoxx.net"}

# Functions

## Create the PEM format file
create_pem()
{
  cat ${CERT_DIR}/${FQDN}.crt ${CERT_DIR}/${FQDN}.key | tee ${CERT_DIR}/${FQDN}.pem
}

## Create the certificate
generate_cert()
{
  # Create the key and CSR
  openssl req -nodes \
    -newkey rsa:${BITS} \
    -keyout ${CERT_DIR}/${FQDN}.key \
    -out ${CERT_DIR}/${FQDN}.csr \
    -subj "/C=US/ST=WA/L=Bellevue/O=Unity Technologies/OU=Cloud Build/CN=${FQDN}"

  # Sign the CSR
  openssl x509 -req \
    -days ${DAYS} \
    -in ${CERT_DIR}/${FQDN}.csr \
    -signkey ${CERT_DIR}/${FQDN}.key \
    -out ${CERT_DIR}/${FQDN}.crt
}

## Check if the cert directory exists
make_cert_dir()
{
  # Create the directory if it doesn't exist yet
  if [[ -n ${CERT_DIR} ]]; then
    mkdir -p ${CERT_DIR}
  fi
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] generate_ssl_cert.bash [options]"
  echo "  Environment Variables:"
  echo "    BITS                bits for the certificate (default: '2048')"
  echo "    CERT_DIR            directory to output to (default: '/etc/ssl/certs')"
  echo "    DAYS                days the cert is valid for (default: '365')"
  echo "    FQDN                fully qualified domain name of the server (default: jenkins.churchoffoxx.net)"
}

# Logic

## Argument parsing
while [[ "$1" != "" ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done

make_cert_dir
generate_cert
create_pem
