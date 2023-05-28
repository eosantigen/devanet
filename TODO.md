- Add my own local domain certificate on the web consoles.
- Maybe split libvirtd.yaml tasks of other settings.
- Unified inventory for everything.
- Configure LDAP for Openstack
- Change domain of hypervisor "aio1.openstack.local" to aio1.openstack.devanet
- Add Domain support (probably requires rebootstrap via Ansible). The following works connecting like a charm, but RBAC fails as expected, and we don't want to connect to the Default domain anyways:
```
# /etc/keystone/keystone.conf

[identity]
driver = ldap
domain_specific_drivers_enabled = True
domain_configurations_from_database = True
domain_config_dir = /etc/keystone/domains

# /etc/keystone/domains/keystone.devanet.conf

[ldap]
url = ldap://ldap.devanet
user = cn=deva,dc=devanet
password = mypassword
suffix = dc=devanet
user_tree_dn = dc=devanet
user_objectclass = inetOrgPerson
user_name_attribute = cn
```
