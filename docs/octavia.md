# Octavia

## Create amphora image

```sh
. octavia-openrc

openstack image create --disk-format qcow2 --container-format bare \
  --private --tag amphora \
  --file amphora-x64-haproxy.qcow2 amphora-x64-haproxy
```
