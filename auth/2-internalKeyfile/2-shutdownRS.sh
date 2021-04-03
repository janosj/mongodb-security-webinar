mongo --port 27017 -u root -p root --eval "db = db.getSiblingDB('admin'); db.shutdownServer()"
mongo --port 27018 -u root -p root --eval "db = db.getSiblingDB('admin'); db.shutdownServer()"
mongo --port 27019 -u root -p root --eval "db = db.getSiblingDB('admin'); db.shutdownServer()"

