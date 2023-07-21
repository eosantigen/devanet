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

Restart the Keystone service: `sudo systemctl restart keystone-wsgi-public.service`

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
This will succesfully configure Horizon and restart apache2. 

Login and grap the RC file and source it.

Now, logout, and the textfield for the domain input will appear. (there is a dropdown setting but it's not working at least on Firefox.)

## Test LDAP Connection

Try logging in as `eos.antigen` on domain `devanet` . It should say something like "_you have no permissions for this domain."_  . For this, login as `admin` under `default` domain and go to Identity -> Domains -> Set domain context (devanet) -> Manage Members -> it should be able to see the user `eos.antigen`. So now you should be able to log back as `eos.antigen`.

## CLI

- Add the admin role to the default domain, _in order to be able to manage domains_: `openstack role add --domain default --user admin admin --insecure`

- Add the admin role the devanet domain: `openstack role add --domain devanet --user admin admin --insecure` (NOTE: this cannot log in under devanet with the basic auth admin creds.)

- List users under the `default` domain: `openstack user list --domain default --insecure`

- Create `devanet` domain: `openstack domain create --description "For Personal Development --insecure" devanet`