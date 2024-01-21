# NOTE: THIS FILE IS NOT TO BE EXECUTED WHOLE AS IS.

# Generate the config file template:
ansible-config init --disabled > /tmp/ansible.cfg

# Check connectivity to your hosts:
ansible -m ping all

# Install some non-builtin library:
ansible-galaxy collection install community.libvirt

# Show the inventory's hierarchy - also useful for the vars placement/inheritance:
ansible-inventory --list

# Show basic system info:
ansible -m ansible.builtin.setup all --args \
    'filter=all_ipv4_addresses,dns,interfaces,network,os_family,python_version,user_shell'

# Run a shell command somewhere - e.g. Grab the Keystone admin password:
ansible os.devanet -b -K --ask-pass -m ansible.builtin.shell -a 'grep keystone_auth_admin_password /etc/openstack_deploy/user_secrets.yml'