# DevaNet

Initially, it runs on the default bridged network **192.168.122.0/24** .
There is no DHCP, but static configuration.

## Base Host - DevaPC

This is using NetworkManager via Netplan to manage networking so we can use the following command to check details:
```
nmcli connection
nmcli connection show Wired\ connection\ 1
```
---
```
Hostname: DevaPC
OS: Ubuntu 22.10
IP CIDR: 192.168.1.0/24
Gateway: 192.168.1.254
DNS: 192.168.1.254
```
## Base VM - Proxmox VE

```
Hostname: pve.devanet
OS: Proxmox VE 7.3_3
IP CIDR: 192.168.122.2/24
Gateway: 192.168.122.1
DNS: 192.168.122.1
```
## Kubernetes Control Plane Node

```
Hostname: kc1.devanet
OS: Ubuntu Server 22.10
IP CIDR: 192.168.122.3/24
Gateway: 192.168.122.1
DNS: 192.168.122.1
```