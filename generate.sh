#!/bin/bash

CA_FILE_NAME="root"
CERT_FILE_NAME="mycompany"

echo "[1] Generating root CA certificate and private key..."
openssl req -x509 -newkey rsa:2048 -out "$CA_FILE_NAME.crt" -outform PEM -keyout "$CA_FILE_NAME.key" -days 3650 -verbose -config ca.cnf -nodes -sha256

echo "[2] Generating certificate request and private key..."
openssl req -newkey rsa:2048 -keyout "$CERT_FILE_NAME.key" -out "$CERT_FILE_NAME.csr" -sha256 -nodes -config crt.cnf

echo "[3] Generating certificate..."
openssl x509 -req -CAcreateserial -CA "$CA_FILE_NAME.crt" -CAkey "$CA_FILE_NAME.key" -in "$CERT_FILE_NAME.csr" -out "$CERT_FILE_NAME.crt" -days 3650 -extfile crt.cnf -extensions v3_req -sha256

echo "[4] Done."
