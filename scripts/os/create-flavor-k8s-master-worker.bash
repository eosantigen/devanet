#!/usr/bin/env bash

openstack flavor create \
  --insecure \
  --public \
  --ram 4096 \
  --vcpus 2 \
  --disk 20 \
  k8s-master

openstack flavor create \
  --insecure \
  --public \
  --ram 6144 \
  --vcpus 4 \
  --disk 40 \
  k8s-worker