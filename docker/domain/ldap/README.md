# LDAP across DevaNet

## Use Cases

- Logbook web app auth
- DevaWeb web app auth
- Openstack UI auth
- Proxmox UI auth

## Configuration

`docker exec ldap ldapadd -x -D "cn=deva,dc=devanet" -f users.ldif -w deva`

or,

`docker exec ldap ldapadd -x -D "cn=deva,dc=devanet" -f users.ldif -w deva`

and

`docker exec ldap ldapsearch -x -b dc=devanet -D "cn=deva,dc=devanet" -w deva`

or,

`docker exec ldap ldapsearch -x -b dc=devanet -D "cn=deva,dc=devanet" -w deva`

**Change user's password**

`docker exec -it ldap ldappasswd -x -D "cn=deva,dc=devanet" -W -S "cn=eos.antigen,dc=devanet"`


### Proxmox

Given the tree here, you need to add **cn** as the User Attribute Name. Add a new group and give it a newly created permission LDAP_ADMIN for the / with Propagate.