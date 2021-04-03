db = db.getSiblingDB('admin');
db.createUser( {
  user:"userAdmin", pwd:"userAdmin",
  roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
} )

