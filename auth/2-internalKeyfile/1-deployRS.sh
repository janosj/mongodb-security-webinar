#!/bin/bash

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
echo "Creating keyfile in $RS_BASE..."
openssl rand -base64 756 > $RS_BASE/keyfile
chmod 400 $RS_BASE/keyfile

mkdir -p $RS_BASE/data1
mkdir -p $RS_BASE/data2
mkdir -p $RS_BASE/data3

echo
echo "Launching Mongo1 on port 27017..."
mongod --fork --replSet "rs0" --port 27017 --dbpath $RS_BASE/data1 --logpath $RS_BASE/data1/mongodb.log --auth --keyFile $RS_BASE/keyfile
echo "Launching Mongo2 on port 27018..."
mongod --fork --replSet "rs0" --port 27018 --dbpath $RS_BASE/data2 --logpath $RS_BASE/data2/mongodb.log --auth --keyFile $RS_BASE/keyfile
echo "Launching Mongo3 on port 27019..."
mongod --fork --replSet "rs0" --port 27019 --dbpath $RS_BASE/data3 --logpath $RS_BASE/data3/mongodb.log --auth --keyFile $RS_BASE/keyfile

echo
echo "Initiating Replica Set..."
mongo initiateRS.js

echo
echo "RS deployed and initiated. Check status with rs.conf(), then create users."

