# DevaNet: A Mini Cloud in a PC

## Intro

The mini cloud is all nested inside a single but large VM which is managed by libvirtd and which hosts an Openstack all-in-one deployment.

## Requirements and specs

First of all, it is imperative to check some hardware specs [here](./NETPLAN.md), and also, the VM/domain specification [here](./ansible/libvirtd/templates), because the whole VM is taking up the whole of a second attached disk to the PC, `/dev/sdb`, which is used only for this purpose. _(executing the following step simply means erasing everything in this disk...)_

## Setup the whole VM ecosystem

If all is ok with your specs, setup [libvirt](https://libvirt.org/docs.html) and with it create the base VM with the Ansible playbook _(run this playbook only once, or if you want to start full from scratch, as it re-creates the VM each time!)_

`ansible-playbook libvirtd.yaml -e node=DevaPC`

### Install OpenStack

After a clean Ubuntu Server installation, with the given specs and options, this command will take roughly 60' : `ansible-playbook -i inventory/devanet.ini openstack-aio.yaml --ask-pass -K`

## How to start the ecosystem

1. `cd docker/domain; docker compose up`
2. Auto-boot is disabled, so, on each reboot of the base host, start the base VM with: `virsh pool-start devanet && virsh start devanet`
3. Get a VNC connection to `localhost:9090` and opt accordingly (reinstall or `ctrl+alt+delete` -> ESC -> 2 to start the installed system.)

### Login

1. Launch https://os.devanet (or https://192.168.122.2 if the DNS container fails... _however, if DNS fails, the login will fail as well..._)
2. Login on either `default` or `devanet` domain:
  - either as `admin` with password found with:
  ```sh
  ssh-keygen -f ~/.ssh/known_hosts -R "os.devanet"; ssh-keygen -f ~/.ssh/known_hosts -R "os"; cd ansible; ansible os.devanet -b -K --ask-pass -m ansible.builtin.shell -a 'grep keystone_auth_admin_password /etc/openstack_deploy/user_secrets.yml'
  ```
  - or as `eos.antigen` with password set on the LDAP instance as described [here](./docker/domain/ldap/README.md), on ideally domain `devanet`.

---

## Aim of this project

To have fun by examining configurations of the following (_to some possible extend, at least_):

- [libvirt](https://libvirt.org/docs.html)
- [Openstack](https://www.openstack.org/)
- [Kubernetes](https://kubernetes.io/)
- [Openstack Cloud Controller Manager](https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/openstack-cloud-controller-manager/using-openstack-cloud-controller-manager.md)
- [Microk8s](https://microk8s.io/) & [K3s](https://k3s.io/)
- Service Mesh & [Dapr](https://docs.dapr.io/concepts/service-mesh/)
- Observability: distributed tracing, metrics, logging - with the Grafana stack, Prometheus, [NetData](https://www.netdata.cloud/netdata-vs-prometheus/), Jaeger & [OpenTelemetry](https://opentelemetry.io/)
- CI/CD and various pipelines for various jobs and for applications based on Python, Java, Nodejs, and Ruby on Rails, _including_:
  - [Apache Airflow](https://airflow.apache.org/)
  - [ArgoCD](https://argo-cd.readthedocs.io/)
  - [Gitlab](https://docs.gitlab.com/ee/install/docker.html)
- Software-defined networking and NFV with [OpenDaylight](https://www.opendaylight.org/) & [Open vSwitch](https://www.openvswitch.org/)
