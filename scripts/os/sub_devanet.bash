#!/usr/bin/env bash

openstack subnet create \
  --insecure \
  --gateway 192.168.122.1 \
  --subnet-range 192.168.122.0/24 --gateway 192.168.122.1 \
  --network devanet --allocation-pool start=192.168.122.3,end=192.168.122.253 \
  --dns-nameserver 192.168.122.1 \
  devanet