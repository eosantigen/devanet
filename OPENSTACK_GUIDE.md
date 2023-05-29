# Enable Domains

In Horizon, the Domains UI component seems to be inactive... First, you configure the Identity to be able to use the LDAP driver, add your own LDAP config, and enable the UI view in Horizon.

---

In `/etc/keystone/keystone.conf` add only the following:

```
[identity]
...
domain_specific_drivers_enabled = True
domain_config_dir = /etc/keystone/domains
```

In `/etc/keystone/domains/keystone.DEVANET.conf` add only the following:

```
[DEVANET]

[identity]
driver = ldap

[ldap]
url = ldap://ldap.devanet
user = cn=deva,dc=devanet
password = mysupersecurepassword
suffix = dc=devanet
user_tree_dn = dc=devanet
user_objectclass = inetOrgPerson
user_name_attribute = cn
```

Add the following to the Horizon Ansible Playbook `/etc/openstack_deploy/user_variables_horizon.yml` :

```
horizon_keystone_multidomain_support: True
```
Then, execute the Playbook, as this:
```
export SCENARIO='aio_metal_horizon_metal'
cd /opt/openstack-ansible
sudo openstack-ansible playbooks/os-horizon-install.yml 
```
This will succesfully configure Horizon and restart apache2, but, lastly you also need to :
`openstack role add --domain default --user admin admin`

Now, logout, and the textfield for the domain input will appear. (there is a dropdown setting but it's not working at least on Firefox.)

---