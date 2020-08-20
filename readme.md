## Requirements
- virtualbox or libvirt
- python virtualenv
- vagrant

## Steps:
Initialize kubespray submodule
```
git submodule init  && git submodule update
```
Run the commands from kubespray directory
```
cd kubespray
sh ../vagrant.sh
```

## Install Rook storage

**Add rook repo**
```
helm repo add rook-release https://charts.rook.io/release
```
**Create rook namespace**

```
kubectl create ns rook-ceph
```

**Install rook**

```
helm install --namespace rook-ceph rook-ceph rook-release/rook-ceph
```

**Create rook cluster**
```
kubectl apply -f rook/cluster/examples/kubernetes/ceph/cluster.yaml
```

**Create storage class**

```
kubectl apply -f rook/cluster/examples/kubernetes/ceph/storageclass-bucket-delete.yaml
```
