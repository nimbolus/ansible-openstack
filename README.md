# ansible-openstack

## Requirements

Generate secrets by run ansible locally:

```sh
ansible localhost -m template -a "src=secrets.yml.j2 dest=secrets.yml"
```

Next create certificate authority and save the key at `/etc/openstack-ca/private/ca.key` 
and the certificate at `/etc/openstack-ca/certs/ca.crt` on the ca node. Remember to use
the password from `secrets_ca_key_pass` to encrypt the key.
To install the certificate authority into the system and start a few initial tasks run:

```sh
ansible-playbook main.yml --tags ca,bootstrap --extra-vars "ca_install_trust=true"
```

Finally restart all nodes.

## Installation

```sh
ansible-playbook main.yml
```

## Discover new compute nodes

```sh
ansible controller1 -m shell -b -a 'su -s /bin/sh -c "nova-manage cell_v2 discover_hosts" nova'
```

