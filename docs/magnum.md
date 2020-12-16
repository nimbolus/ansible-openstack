# Magnum

Set `magnum_cinder_volume_type` to an existing cinder volume type first.

## Upload Fedora CoreOS image

Download Fedora CoreOS from [getfedora.org](https://getfedora.org/en/coreos/download?tab=metal_virtualized&stream=stable) and extract it.

Next upload it to glance:
```sh
openstack image create \
    --disk-format=qcow2 \
    --file=fedora-coreos-32-openstack.x86_64.qcow2 \
    --property os_distro='fedora-coreos' \
    fedora-coreos-32
```

## Create template for Kubernetes cluster

Create a template based on Fedora CoreOS:
```sh
openstack coe cluster template create test-template \
    --image fedora-coreos-32 \
    --external-network provider1 \
    --dns-nameserver 9.9.9.9 \
    --master-flavor m1.medium \
    --flavor m1.medium \
    --docker-volume-size 20 \
    --docker-storage-driver overlay \
    --keypair my-ssh-key \
    --network-driver calico \
    --coe kubernetes
```

## Create Kubernetes cluster

```sh
openstack coe cluster create test-cluster \
    --cluster-template test-template \
    --master-count 1 \
    --node-count 1
```

## Get kubeconfig file

```sh
openstack coe cluster config test-cluster
```
