# Use ldapsearch to test connectivity to AD.

source settings.conf

# Contains the ldapsearch utility (RHEL).
sudo yum install -y openldap-clients

# Active Directory does not support anonymous binds.
# You have to create a user in AD and connect using that account.
# Also, Active Directory is not configured for SSL by default. 

ldapsearch -x -h $AD_HOST -p $AD_PORT -D $AD_BIND_USER -w $AD_BIND_PWD -b $AD_SEARCH_BASE cn

# -H: LDAP URI
# -h: LDAP host, deprecated in favor of -H
# -p: LDAP port, deprecated in favor of -H
# -x: use simple authentication instead of SASL
# -D: bind DN (simple binds, ignored for SASL)
# -v: verbose
# -b: search base
# -W: prompt for password
# -w: password
# -o ldif-wrap=no : options, no wrapping
# -LLL: output format. See man page.
# ldapsearch -H ldaps://ldap.example.org -x -D uid=someuser,cn=accounts,dc=example,dc=org -b "dc=example,dc=org" -W -o ldif-wrap=no -LLL sn=Lastname displayname mail

