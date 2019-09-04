# Ceph

```sh
ceph osd pool create cinder 128
rbd pool init cinder
ceph auth get-or-create client.cinder mon 'profile rbd' osd 'profile rbd pool=cinder'
```

Show volumes with: `rbd ls cinder`

## Setup cinder volume type

For example for ceph ssd storage:
```sh
openstack volume type create ceph-ssd
openstack volume type set ceph-ssd --property volume_backend_name=rbd_volumes
```
