# DevaNet

Initially, it runs on the `libvirt` default NAT-based bridge network **192.168.122.0/24** . There is no DHCP, only static IP, for the nested VMs launched within this net, via a bridge.

The setup also includes 2 Docker containers, a DNS server (with Bind9) and an LDAP server, that run on the base host, and are reachable from this net, as well. The purpose of the DNS server is mainly for experimentation but the LDAP server is also meant to provide a unified auth account base for easy usage across various applications.

**Network Setup Overview**

![Overview 1](./media/devanet_overview.png)

## Base Host - DevaPC

### Specs
```
Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz
Memory speed: (4 x 8192 MB) @ 2133 MT/s each
```
### Connection details
This is using NetworkManager via Netplan to manage networking so we can use the following command to check details:
```
nmcli connection
nmcli connection show Wired\ connection\ 1
```
---
```
Hostname: DevaPC
OS: Ubuntu 22.10
IP CIDR: 192.168.1.5/24
Gateway: 192.168.1.254
DNS: 192.168.1.254
```
## Base VM - Proxmox VE

### Specs

CPU: 8
Memory: 24GB

### Connection details

```
Hostname: pve.devanet
OS: Proxmox VE 7.3_3
IP CIDR: 192.168.122.2/24
Gateway: 192.168.122.1
DNS: 192.168.122.1
```
## Nested VM within PVE - Kubernetes Control Plane Node

### Specs

- CPU: 2 - 4 (limit)

- Memory: 6GB

```
Hostname: kc1.devanet
OS: Ubuntu Server 22.10
IP CIDR: 192.168.122.3/24
Gateway: 192.168.122.1
DNS: 192.168.122.1
```

## Nested VM within PVE - Kubernetes Worker Node

### Specs

- CPU: 2 - 4 (limit)

- Memory: 6GB

```
Hostname: kw1.devanet
OS: Ubuntu Server 22.10
IP CIDR: 192.168.122.4/24
Gateway: 192.168.122.1
DNS: 192.168.122.1
```