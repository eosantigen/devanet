# DevaNet: Virtualisation Testbed

## Setup

### One-off configurations

To make your life easier, edit `/etc/libvirt/qemu.conf` to contain these:
```
user = "eosantigen"
group = "eosantigen"
security_driver = "none"
```
`sudo systemctl restart libvirtd`

Create the base VM with the Ansible playbook _(run this playbook only once, as it re-creates the VM each time)_

`ansible-playbook libvirtd.yaml -e node=DevaPC`

### Steps to start the ecosystem

1. `cd docker/domain; docker compose up`
2. Auto-boot is disabled, so, on each reboot of the base host, start the base VM with: `virsh pool-start devanet && virsh start devanet`

#### On Proxmox

Launch https://192.168.122.2:8006 and login with domain `devanet` _(LDAP)_ .

#### On Openstack

Launch https://192.168.122.2 and login as `admin` with password found under `/etc/openstack_deploy/user_secrets.yml` (`keystone_auth_admin_password`).

---

## Aim of this project

To have fun by examining configurations of the following (_to some possible extend, at least_):

- [libvirt](https://libvirt.org/docs.html)
- [Openstack](https://www.openstack.org/)
- [Kubernetes](https://kubernetes.io/)
- [Openstack Cloud Controller Manager](https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/openstack-cloud-controller-manager/using-openstack-cloud-controller-manager.md)
- [Microk8s](https://microk8s.io/)
- Service Mesh
- Observability (distributed tracing, metrics, logging with the Grafana stack, Prometheus, Jaeger & [OpenTelemetry](https://opentelemetry.io/))
- CI/CD and various pipelines for applications based on Python, JVM, Nodejs, and Ruby on Rails, _including_:
  - [Apache Airflow](https://airflow.apache.org/)
  - [ArgoCD](https://argo-cd.readthedocs.io/)
  - [JenkinsX](https://jenkins-x.io/)
  - [Tekton](https://tekton.dev/)
- CDN for applications
- CKS study context, and the NSA hardening configurations
- Messaging and event-driven systems
- Micro-services and micro-frontends (with emphasis on the Reactive principle)
- Real-time analytics for event-driven data on web applications with [Apache Druid](https://druid.apache.org/faq)
- Software-defined networking and NFV with [OpenDaylight](https://www.opendaylight.org/) & [Open vSwitch](https://www.openvswitch.org/)
