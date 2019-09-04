# Magnum

Set `magnum_cinder_volume_type` to an existing cinder volume type first. 

## Upload fedora atomic image

Download and create a Fedora Atomic image:
```sh
wget https://ftp-stud.hs-esslingen.de/pub/Mirrors/alt.fedoraproject.org/atomic/stable/Fedora-29-updates-20190820.0/AtomicHost/x86_64/images/Fedora-AtomicHost-29-20190820.0.x86_64.qcow2
openstack image create \
    --disk-format=qcow2 \
    --file=Fedora-AtomicHost-29-20190820.0.x86_64.qcow2 \
    --property os_distro='fedora-atomic' \
    fedora-atomic-29
```

## Create template for kubernetes cluster

Create a template based on Fedora Atomic:
```sh
openstack coe cluster template create kubernetes-example \
    --image fedora-atomic-29 \
    --external-network siticom_corp \
    --dns-nameserver 10.120.11.10 \
    --master-flavor m1.small \
    --flavor m1.small \
    --docker-volume-size 30 \
    --docker-storage-driver overlay \
    --volume-driver cinder \
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
