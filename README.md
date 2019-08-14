# ansible-openstack

## Requirements

Create certificate authority at `/etc/openstack-ca` and save the key at `private/ca.key` and the certificate at `certs/ca.crt`.
To install the certificate authority into the system run:

```sh
ansible-playbook main.yml --tags ca --extra-vars ca_install_trust=true
```

Next configure the provider network interface on the network nodes. 
The interface file at `/etc/sysconfig/network-scripts` should contain the following values, but don't remove the existing options.

```
BOOTPROTO=none
ONBOOT=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=no
IPV6_FAILURE_FATAL=no
```

## Installation

    ansible-playbook main.yml

## Discover new compute nodes

    ansible controller1 -m shell -b -a 'su -s /bin/sh -c "nova-manage cell_v2 discover_hosts" nova'
