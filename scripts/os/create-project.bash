#!/usr/bin/env bash

# Invocation: ./create-project.bash devanet Kubernetes kubernetes

openstack project create \
  --insecure \
  --domain $1 \
  --description $2 \
  --enable \
  $3