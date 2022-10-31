# Bridged networking

- not using master/slave because it disables the manual method and switches to auto, we don't want that.
- we use the bridged mode for the openstackaio host so as to be able to experiment on it from another machine on the LAN. __(ideally, at least...)__

Check with :
- `nmcli connection show br0`
- `ip add`

Should contain:

```
connection.type:                        bridge
connection.interface-name:              br0
connection.autoconnect:                 yes
ipv4.method:                            manual
ipv4.dns:                               127.0.0.53
ipv4.addresses:                         192.168.1.11/24
ipv4.gateway:                           192.168.1.254
IP4.ADDRESS[1]:                         192.168.1.11/24
IP4.GATEWAY:                            192.168.1.254
IP4.ROUTE[1]:                           dst = 192.168.1.0/24, nh = 0.0.0.0, mt = 427
IP4.ROUTE[2]:                           dst = 0.0.0.0/0, nh = 192.168.1.254, mt = 20427
IP4.DNS[1]:                             127.0.0.53
```