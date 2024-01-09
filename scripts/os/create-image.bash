#!/usr/bin/env bash

openstack image create \
  --insecure \
  --public \
  --file /home/eosantigen/Downloads/ubuntu-22.04.2-live-server-amd64.iso
  ubuntu-server-lts
