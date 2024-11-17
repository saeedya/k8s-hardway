#!/bin/bash

suorce prerequisites.sh

if [ -d "./certs" ]; then
    echo "Directory exists."
else
    echo "Directory does not exist,Creating certs directory..."
    mkdir certs
fi

echo "Creating a new private key..."
openssl genrsa -out ./certs/ca.key 2048

sleep 1

echo "Creating a new self-signed certificate..."
openssl req -x509 -new -nodes -key ./certs/ca.key -sha256 -days 3650 -out ./certs/ca.crt -subj "/C=IE/ST=Westmeath/L=Athlone/O=MyOrganization/OU=IT/CN=MyRootCA"

echo "creating etcd private key..."
openssl genrsa -out ./certs/etcd.key 2048

sleep 1

echo "Creating a new certificate signing request for etcd..."
openssl req -new -key ./certs/etcd.key -out ./certs/etcd.csr -subj "/C=IE/ST=Westmeath/L=Athlone/O=MyOrganization"

sleep 1

echo "Sign the certificate signing request..."
openssl x509 -req -in ./certs/etcd.csr -CA ./certs/ca.crt -CAkey ./certs/ca.key -CAcreateserial -sha256 > ./certs/etcd.crt