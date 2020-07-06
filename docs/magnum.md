# Magnum

Set `magnum_cinder_volume_type` to an existing cinder volume type first. 

## Upload Fedora CoreOS image

Download and create a Fedora CoreOS image:
```sh
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/32.20200615.3.0/x86_64/fedora-coreos-32.20200615.3.0-openstack.x86_64.qcow2.xz
xz -d fedora-coreos-32.20200615.3.0-openstack.x86_64.qcow2.xz
openstack image create \
    --disk-format=qcow2 \
    --file=fedora-coreos-32.20200615.3.0-openstack.x86_64.qcow2 \
    --property os_distro='fedora-coreos' \
    fedora-coreos-32
```

## Create template for kubernetes cluster

Create a template based on Fedora Atomic:
```sh
openstack coe cluster template create kubernetes-example \
    --image fedora-coreos-32 \
    --external-network cloud \
    --dns-nameserver 10.64.1.1 \
    --master-flavor m1.medium \
    --flavor m1.medium \
    --docker-volume-size 30 \
    --docker-storage-driver overlay \
    --coe kubernetes
```

## Create kubernetes cluster

```sh
openstack coe cluster create kubernetes-cluster \
    --cluster-template kubernetes-example \
    --master-count 1 \
    --node-count 1 \
    --keypair keycard
```
