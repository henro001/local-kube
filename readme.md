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
# Storage


## Install local path provisioner

```
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```

Set default storage class

```
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```


# Work in progress, use at your own risk.....

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
