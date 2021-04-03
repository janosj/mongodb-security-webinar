#!/bin/bash

echo "Making Changes for internal x509 authentication"

echo "Generates a 3-node replica set (localhost ports 27017|18|19)"
echo "with access control enabled and internal authentication "
echo "accomplished via keyfile."
echo 

if [ -z "$HOME" ]
then
  echo "\$HOME not set."
  exit
fi

RS_BASE=$HOME/db/rs
echo "Base location for new replica set will be $RS_BASE"

echo "!! About to delete $RS_BASE !!"
echo "This script will build a new MongoDB replica set in that location."
read -p "Press enter to acknowledge."

rm -rf $RS_BASE
mkdir -p $RS_BASE

echo
echo "Creating certs in $RS_BASE..."
cd $RS_BASE
#there are requirements for member certificates that this doesn't meet
openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -subj "/CN=myserver1.local,O=MongoDB" -days 365 -out server.crt
#openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -subj "/CN=localhost,O=MongoDB" -days 365 -out server.crt
cat server.crt server.key > server.pem
cd -

mkdir -p $RS_BASE/data1
mkdir -p $RS_BASE/data2
mkdir -p $RS_BASE/data3

echo
echo LAUNCHING IN OPEN MODE
echo

echo
echo "Launching Mongo1 on port 27017..."
#mongod --fork --replSet "rs0" --port 27017 --dbpath $RS_BASE/data1 --logpath $RS_BASE/data1/mongodb.log --auth --tlsMode requireTLS --clusterAuthMode x509 --tlsClusterFile $RS_BASE/server.pem --tlsCertificateKeyFile $RS_BASE/server.pem --tlsCAFile $RS_BASE/server.pem --tlsAllowConnectionsWithoutCertificates
mongod --fork --replSet "rs0" --port 27017 --dbpath $RS_BASE/data1 --logpath $RS_BASE/data1/mongodb.log --bind_ip myserver1.local

echo "Launching Mongo2 on port 27018..."
#mongod --fork --replSet "rs0" --port 27018 --dbpath $RS_BASE/data2 --logpath $RS_BASE/data2/mongodb.log --auth --tlsMode requireTLS --clusterAuthMode x509 --tlsClusterFile $RS_BASE/server.pem --tlsCertificateKeyFile $RS_BASE/server.pem --tlsCAFile $RS_BASE/server.pem --tlsAllowConnectionsWithoutCertificates
mongod --fork --replSet "rs0" --port 27018 --dbpath $RS_BASE/data2 --logpath $RS_BASE/data2/mongodb.log --bind_ip myserver1.local

echo "Launching Mongo3 on port 27019..."
#mongod --fork --replSet "rs0" --port 27019 --dbpath $RS_BASE/data3 --logpath $RS_BASE/data3/mongodb.log --auth --tlsMode requireTLS --clusterAuthMode x509 --tlsClusterFile $RS_BASE/server.pem --tlsCertificateKeyFile $RS_BASE/server.pem --tlsCAFile $RS_BASE/server.pem --tlsAllowConnectionsWithoutCertificates
mongod --fork --replSet "rs0" --port 27019 --dbpath $RS_BASE/data3 --logpath $RS_BASE/data3/mongodb.log --bind_ip myserver1.local

exit

echo
echo "Initiating Replica Set..."
mongo --host localhost --tls --tlsCAFile $RS_BASE/server.pem initiateRS.js

echo
echo "RS deployed and initiated. Check status with rs.conf(), then create users."

