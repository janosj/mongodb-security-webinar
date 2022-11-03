// Creates the user administrator account.
db = db.getSiblingDB("$external");
db.createUser( {
  user:"CN=First Last,CN=Users,DC=testad,DC=corp",
  roles: [ "root" ]
} )

# This produces an error: 
# "Could not find role: root@$external"
db.createUser( { user:"CN=First Last,CN=Users,DC=testad,DC=corp", roles: [ "root" ] } )

# This works:
db.createUser( { user:"CN=First Last,CN=Users,DC=testad,DC=corp", roles: [ { role: "root", db: "admin" } ] } )

