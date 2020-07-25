# NFS

## Setup cinder volume type

For example for nfs ssd storage:
```sh
openstack volume type create nfs-ssd
openstack volume type set nfs-ssd --property volume_backend_name=nfs
```
