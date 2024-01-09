#!/usr/bin/env bash

openstack server create \
  --insecure \
  --flavor devatest \
  --network devanet \
  --image ubuntu-server-lts \
  devatest