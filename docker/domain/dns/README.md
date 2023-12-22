# DNS across DevaNet

## Have to set a static IP for DevaPC

Have also set a DHCP bind through the LAN router config, because otherwise the router didn't handle the DHCP lease distribution properly leading to conflicts .

---

Netplan uses NetworkManager to handle the connections, so, in `/etc/NetworkManager/system-connections/Wired\ connection\ 1.nmconnection` , the following must be:

```
[ipv4]
# method=auto
addresses=192.168.1.1/24
gateway=192.168.1.254
dns=192.168.1.254
method=manual

# or as of latest:

address1=192.168.1.1/24,192.168.1.254
dns=192.168.1.254;
method=manual
```
And then:
```
systemctl restart NetworkManager.service
systemctl restart systemd-networkd.service
```

## Test DNS Resolution via the container

If this fetches the record, `dig @localhost ldap.devanet` or `dig @DevaPC ldap.devanet` (provided it resolves to `127.0.0.1` in `/etc/hosts`), containing `SERVER: 127.0.0.1#53(DevaPC) (UDP)` , then it works!
The mandatory option of __@server__ may be ommitted if:

1. In `/etc/systemd/resolved.conf` we add:
```
DNS=127.0.0.1#53
FallbackDNS=127.0.0.1#53
Domains=devanet
```

2. Run `systemctl restart systemd-resolved.service` .

3. Check with `resolvectl` :

```
Global
           Protocols: -LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported
    resolv.conf mode: stub
  Current DNS Server: 127.0.0.1#53
         DNS Servers: 127.0.0.1#53
Fallback DNS Servers: 127.0.0.1#53
          DNS Domain: devanet

Link 2 (eno1)
    Current Scopes: DNS
         Protocols: +DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported
Current DNS Server: 192.168.1.254
       DNS Servers: 192.168.1.254
```

It will now work as `dig ldap.devanet` .

**BONUS** : _In the container's logs you can see what NS are called from your entire system..._

## Use case 1

We need DevaPC (the DevaNet "platform" base host) to use the *dns* and the *ldap* instances which run in containers on it.

Along, we also need the container's DNS information to be injected into the containers, so that they will resolve each other's name (as is not possible with `NetworkMode: host`). => TODO: for this maybe the base host resolver needs to be tweaked.

## Use case 2

Break down various services running on Docker into custom bridge nets and play with them in acl.

## Explanation

### Testing blocked IPs from querying the DevaNet DNS server

We have ACL in the DNS config that has not yet allowed source IP other than itself (192.168.1.1) to call this service. For example:

**From the the default bridged network 192.168.122.0/24**

The Proxmox base VM, pve.devanet, has IP : `192.168.122.2` . Same will be for the kc1.devanet `192.168.122.3`

```
root@pve:~# dig @192.168.1.1 ldap

; <<>> DiG 9.16.33-Debian <<>> @192.168.1.1 ldap
; (1 server found)
......................
; EDE: 18 (Prohibited)
;; QUESTION SECTION:
;ldap.				IN	A

;; Query time: 3 msec
;; SERVER: 192.168.1.1#53(192.168.1.1)
```
This returns:

```
...192.168.122.2#36281 (ldap): query (cache) 'ldap/A/IN' denied (allow-query-cache did not match)
```