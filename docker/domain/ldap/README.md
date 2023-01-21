# LDAP across DevaNet

## Use Cases

- Logbook web app auth
- DevaWeb web app auth
- Openstack UI auth

## Configuration

`docker exec ldap ldapadd -x -D "cn=deva,dc=devanet" -f users.ldif -w deva`

or,

`docker exec ldap ldapadd -x -D "cn=deva,dc=devanet" -f users.ldif -w deva`

and

`docker exec ldap ldapsearch -x -b dc=devanet -D "cn=deva,dc=devanet" -w deva`

or,

`docker exec ldap ldapsearch -x -b dc=devanet -D "cn=deva,dc=devanet" -w deva`
