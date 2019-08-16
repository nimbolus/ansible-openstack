# ansible-openstack

## Requirements

Create certificate authority and save the key at `/etc/openstack-ca/private/ca.key` 
and the certificate at `/etc/openstack-ca/certs/ca.crt` on the ca node.
To install the certificate authority into the system and start a few initial tasks run:

```sh
ansible-playbook main.yml --tags ca,bootstrap --extra-vars ca_install_trust=true
```

Finally restart all nodes.

## Installation

    ansible-playbook main.yml

## Discover new compute nodes

    ansible controller1 -m shell -b -a 'su -s /bin/sh -c "nova-manage cell_v2 discover_hosts" nova'
