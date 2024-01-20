#!/usr/bin/env bash

openstack server create \
  --insecure \
  --flavor deva \
  --network devanet \
  --image ubuntu-server-lts \
  $1