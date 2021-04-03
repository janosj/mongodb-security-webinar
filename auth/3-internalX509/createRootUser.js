db = db.getSiblingDB('admin');
db.createUser( { user:"root", pwd:"root", roles: [ "root" ] } )

