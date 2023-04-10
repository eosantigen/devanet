# GUIDELINES / TROUBLESHOOTING

## 1 - PREFLIGHT CHECKS

In case kubeadm init fails the pre-flight check for kernel options:
```
modprobe bridge
echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

sysctl -p /etc/sysctl.conf

sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-iptables: No such file or directory sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-ip6tables: No such file or directory

modprobe br_netfilter
sysctl -p /etc/sysctl.conf
```

### CONTAINERD BOOTSTRAP (only if you encounter issues - might be on older version...)

containerd config default > /etc/containerd/config.toml

Edit into:
```
enabled_plugins = ["cri"]
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
            SystemdCgroup = true
```

## 2 - KUBEADM INIT

(installed the bundle as per official Kubernetes docs.)
```
kubeadm init --pod-network-cidr=10.0.0.0/16 --node-name=kc1

[init] Using Kubernetes version: v1.26.3
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kc1 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.122.3]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [kc1 localhost] and IPs [192.168.122.3 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [kc1 localhost] and IPs [192.168.122.3 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 8.003140 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node kc1 as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node kc1 as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: igv04k.2djz5wbulvka85n7
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.122.3:6443 --token <kubeadm token list> --discovery-token-unsafe-skip-ca-verification
```

## 3 - Install Calico/Tigera Pod Network Add-on

### Add the Calico/Tigera Operator

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.1/manifests/tigera-operator.yaml

### Add a slightly custom manifest for network plugin spec

```
# Add this content to e.g. tigera.yaml

# Customised for cidr match to the cidr we passed on the kubeadm.

# This section includes base Calico installation configuration.
# For more information, see: https://projectcalico.docs.tigera.io/master/reference/installation/api#operator.tigera.io/v1.Installation
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  # Configures Calico networking.
  calicoNetwork:
    # Note: The ipPools section cannot be modified post-install.
    ipPools:
    - blockSize: 26
      cidr: 10.0.0.0/16
      encapsulation: VXLANCrossSubnet
      natOutgoing: Enabled
      nodeSelector: all()

---

# This section configures the Calico API server.
# For more information, see: https://projectcalico.docs.tigera.io/master/reference/installation/api#operator.tigera.io/v1.APIServer
apiVersion: operator.tigera.io/v1
kind: APIServer 
metadata: 
  name: default 
spec: {}
```

## 4 - WAIT A BIT, AND THEN...
```
eosantigen@kc1:~$ kubectl get nodes -o wide
NAME   STATUS   ROLES           AGE     VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION      CONTAINER-RUNTIME
kc1    Ready    control-plane   70m     v1.26.3   192.168.122.3   <none>        Ubuntu 22.10   5.19.0-21-generic   containerd://1.6.4-0ubuntu1
kw1    Ready    <none>          2m38s   v1.26.3   192.168.122.4   <none>        Ubuntu 22.10   5.19.0-38-generic   containerd://1.6.12
```

```
eosantigen@kc1:~$ kubectl get pods -A
NAMESPACE          NAME                                       READY   STATUS    RESTARTS   AGE
calico-apiserver   calico-apiserver-6b4d85f485-dxdsm          1/1     Running   0          17m
calico-apiserver   calico-apiserver-6b4d85f485-ptrdn          1/1     Running   0          17m
calico-system      calico-kube-controllers-6bb86c78b4-65ls8   1/1     Running   0          19m
calico-system      calico-node-x4hm8                          1/1     Running   0          19m
calico-system      calico-typha-b7f47b486-khcwq               1/1     Running   0          19m
calico-system      csi-node-driver-4tk5q                      2/2     Running   0          19m
kube-system        coredns-787d4945fb-bggll                   1/1     Running   0          26m
kube-system        coredns-787d4945fb-wcbll                   1/1     Running   0          26m
kube-system        etcd-kc1                                   1/1     Running   29         26m
kube-system        kube-apiserver-kc1                         1/1     Running   29         26m
kube-system        kube-controller-manager-kc1                1/1     Running   0          26m
kube-system        kube-proxy-ffpv7                           1/1     Running   0          26m
kube-system        kube-scheduler-kc1                         1/1     Running   34         26m
tigera-operator    tigera-operator-5d6845b496-lr5tl           1/1     Running   0          20m
```