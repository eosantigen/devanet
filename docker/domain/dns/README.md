# DNS across DevaNet

## Have to set a static IP for DevaPC

Netplan uses NetworkManager to handle the connections, so, in `/etc/NetworkManager/system-connections/Wired\ connection\ 1.nmconnection` , the following must be:

```
[ipv4]
# method=auto
addresses=192.168.1.5/24
gateway=192.168.1.254
dns=192.168.1.254
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
