# e2e test

basic openstack e2e test for network, compute and storage

Steps:

1. Create values.yml file

```yml
parameters:
  public_network_id: <network id>
  ssh_keys: <ssh pub key>
  dns_nameservers: <dns nameserver>
```

2. Create image (default: fedora-cloud-32)

    openstack image create --disk-format=qcow2 --file=<file path> fedora-cloud-32

3. Create stack

    openstack stack create -e e2e-test/values.yml -t e2e-test/template.yml e2e-test

4. Connect via ssh: `fedora@<floating ip>`
5. Delete stack

    openstack stack delete e2e-test
