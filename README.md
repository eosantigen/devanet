# DevaNet: A mini cloud in a PC.

_(or: My PC as a hypervisor with nested VMs)_

## Setup

1. Create the base VM with the Ansible playbook _(run this playbook only once, as it re-creates the VM each time)_
2. `cd docker/domain; docker compose up`
3. Auto-boot is disabled, so, on each reboot of the host, start the base VM with: `sudo virsh start devanet`
4. Login with domain "devanet" (LDAP) on https://192.168.122.2:8006

## Study themes and projects

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
