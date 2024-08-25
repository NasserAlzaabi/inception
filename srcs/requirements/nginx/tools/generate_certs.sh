#!/bin/bash

CERT_FOLDER='../../../../secrets/'

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout ${CERT_FOLDER}/nasser_pkey.pem \
  -out ${CERT_FOLDER}/nasser_cert.crt \
  -subj "/C=AE/ST=AD/L=RAS-ALKHAIMA/O=42AD/CN=naalzaab"