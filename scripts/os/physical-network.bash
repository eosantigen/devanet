#!/usr/bin/env bash

openstack network create \
  --insecure \
  --share \
  --external \
  --provider-physical-network provider \
  --provider-network-type flat \
  devanet
