kill $(ps -ef | grep mongod | grep rs0 | awk '{print $2}')

