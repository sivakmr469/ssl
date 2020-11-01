#!/bin/bash

#Required
domain=$1
commonname=$domain

#Change to your company details
country=SG
state=Singapore
locality=Singapore
organization=mas.gov.sg
organizationalunit=IT
email=sivakmr469@gmail.com

#Optional
password=dummypassword

if [ -z "$domain" ]
then
    echo "Please provide the domain."
    echo "Usage $0 [common name]"
    exit 99
fi

echo "Generating key request for $domain"

#Generate a key
openssl genrsa -des3 -passout pass:$password -out /etc/ssl/private/$domain/$domain.key 2048

echo "private key generated"
#Create the request
echo "Creating CSR"
openssl req -new -key /etc/ssl/private/$domain/$domain.key -out /etc/ssl/csr/$domain/$domain.csr -passin pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

echo "---------------------------"
echo "-----Below is your CSR-----"
echo "---------------------------"
echo
cat /etc/ssl/csr/$domain/$domain.csr