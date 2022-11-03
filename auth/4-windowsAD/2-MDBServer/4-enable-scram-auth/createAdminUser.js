// Creates the user administrator account.
db = db.getSiblingDB("admin");
db.createUser( {
  user:"admin", pwd:"admin",
  roles: [ "root" ]
} )

