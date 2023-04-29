#!/bin/bash

## DESTROY & UNDEFINE

sudo virsh vol-delete sdb1 --pool devanet
sudo virsh pool-destroy devanet
sudo virsh pool-undefine devanet
sudo virsh undefine devanet
sudo virsh destroy devanet