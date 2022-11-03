# Here: https://www.mongodb.com/docs/upcoming/core/security-ldap/#connect-to-a-mongodb-server-via-ldap-authentication

# copied example here:
# https://www.mongodb.com/docs/upcoming/tutorial/configure-ldap-sasl-activedirectory/#authenticate-the-user-in-mongosh

# Error: "authentication PLAIN is not enabled"
mongosh --authenticationMechanism PLAIN --authenticationDatabase '$external' -u "CN=First Last,CN=Users,DC=testad,DC=corp" -p "Password1"

# Solution: add setParameter to mongod.conf file.
setParameter:
   authenticationMechanisms: "PLAIN"

