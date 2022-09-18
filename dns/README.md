# DNS across DevaNet

## Use case 1

We need DevaPC (the DevaNet "platform" base host) to use the *dns* and the *ldap* instances which run in containers on it.

Along, we also need the container's DNS information to be injected into the containers, so that they will resolve each other's name (as is not possible with `NetworkMode: host`). => TODO: for this maybe the base host resolver needs to be tweaked.

## Use case 2

Break down various services running on Docker into custom bridge nets and play with them in acl.