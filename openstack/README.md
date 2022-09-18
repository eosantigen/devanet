## Aims

- Explore the entire ecosystem of Openstack (or at least its key components)
- Get a good grasp and deeper understanding of its capabilities
- Brainstorm on use cases and solutions relative to such a cloud orchestrator platform

## Deployment Method: All-In-One

This is what the current hardware allows for, and it is actually perfect for a fundamental exploration and hypervisor environment.

It includes, as basic, the following key components:

1. **CINDER**: Block storage
2. **GLANCE**: Image service
3. **NEUTRON**: Network
4. **NOVA**: Compute
5. **HORIZON**: Dashboard

Plus, **KEYSTONE** (Identity Service) will be additionally installed for exploring an integration with the LDAP instance already running on the _**DevaPC**_ host. 

## Configurations and the host machine

For minimizing interference with the base system, the _**host_AIO**_ runs on a virtual machine as the with the following specs:
- Ubuntu Server 20.04 as is compatible with the latest release [Yoga](https://www.openstack.org/software/yoga/).
- 330GB root disk _(left with 464GB, plus 223GB on another SSD disk)_
- 27GB RAM _(left with 4GB)_
- 10 vCPU _(left with 2)_
- Network mode: bridged
- VT-X / nested virtualization
- Use KVM for better speed

### Physical host hardware specs
```
Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz (L2 cache: 1,5 MiB - L3 cache: 15 MiB)
CPUs: 12
Sockets: 1
Cores per socket: 6
Threads per core: 2
Memory Speed: (4 x 8192 MB) @ 2133 MT/s each
Hostname: DevaPC
```
---

