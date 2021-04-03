#!/bin/bash

RS_BASE=$HOME/db/rs


echo
echo "Launching Mongo1 on port 27017..."
mongod --fork --replSet "rs0" --port 27017 --dbpath $RS_BASE/data1 --logpath $RS_BASE/data1/mongodb.log --auth --tlsMode requireTLS --clusterAuthMode x509 --tlsClusterFile $RS_BASE/server.pem --tlsCertificateKeyFile $RS_BASE/server.pem --tlsCAFile $RS_BASE/server.pem --tlsAllowConnectionsWithoutCertificates --bind_ip myserver1.local --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames

echo "Launching Mongo2 on port 27018..."
mongod --fork --replSet "rs0" --port 27018 --dbpath $RS_BASE/data2 --logpath $RS_BASE/data2/mongodb.log --auth --tlsMode requireTLS --clusterAuthMode x509 --tlsClusterFile $RS_BASE/server.pem --tlsCertificateKeyFile $RS_BASE/server.pem --tlsCAFile $RS_BASE/server.pem --tlsAllowConnectionsWithoutCertificates --bind_ip myserver1.local --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames

echo "Launching Mongo3 on port 27019..."
mongod --fork --replSet "rs0" --port 27019 --dbpath $RS_BASE/data3 --logpath $RS_BASE/data3/mongodb.log --auth --tlsMode requireTLS --clusterAuthMode x509 --tlsClusterFile $RS_BASE/server.pem --tlsCertificateKeyFile $RS_BASE/server.pem --tlsCAFile $RS_BASE/server.pem --tlsAllowConnectionsWithoutCertificates --bind_ip myserver1.local --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames


