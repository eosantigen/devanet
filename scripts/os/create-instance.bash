#!/usr/bin/env bash

# Invocation: ./create-instance.bash <some_flavor> <instance_name>

openstack server create \
  --insecure \
  --flavor $1 \
  --network devanet \
  --image ubuntu-server-lts \
  $2