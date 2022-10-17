# LDAP across DevaNet

## Use Cases

- Logbook web app auth
- DevaWeb web app auth
- Openstack UI auth

## Configuration

`ldapadd -x -D "cn=deva,dc=devanet" -f users.ldif -w deva`

or,

`ldapadd -x -D "cn=deva,dc=devanet" -f users.ldif -w deva`

and

`ldapsearch -x -b dc=devanet -D "cn=deva,dc=devanet" -w deva`

or,

`ldapsearch -x -b dc=devanet -D "cn=deva,dc=devanet" -w deva`
