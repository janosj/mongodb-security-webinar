#!/bin/bash

RS_BASE=$HOME/db/rs
cd $RS_BASE
#there are requirements for member certificates that this doesn't meet
#openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -subj "/CN=localhost,O=MongoDB" -days 365 -out server.crt
openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -subj "/CN=myserver1.local,O=MongoDB" -addext "subjectAltName = DNS:myserver1.local" -days 365 -out server.crt
#openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -subj "/CN=myserver1,O=MongoDB" -days 365 -out server.crt
#openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -subj "/CN=localhost, O=MongoDB" -days 365 -out server.crt
cat server.crt server.key > server.pem
cd -


