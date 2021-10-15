# Octavia

## Amphora image

For image build process consult [amphora-image-build](https://docs.openstack.org/octavia/latest/admin/amphora-image-build.html).

### Upload amphora image
```sh
source octavia-openrc
openstack image create --disk-format qcow2 --container-format bare \
  --private --tag amphora \
  --file amphora-x64-haproxy.qcow2 amphora-x64-haproxy
```
