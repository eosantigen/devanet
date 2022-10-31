#!/usr/bin/env bash

# ansible-config init --disabled > /tmp/ansible.cfg
# ansible -m ping all
# ansible-galaxy collection install community.libvirt
ansible-inventory --list
ansible -m ansible.builtin.setup all --args \
    'filter=all_ipv4_addresses,dns,interfaces,network,os_family,python_version,user_shell'