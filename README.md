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
ansible-playbook main.yml --tags ca,bootstrap --extra-vars "ca_install_trust=true bootstrap_system_upgrade=true"
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

## Upgrade

Set `bootstrap_openstack_release` to new release and run:
```sh
ansible-playbook main.yml --tags bootstrap
ansible-playbook main.yml --extra-vars "package_state=latest" --tags openstack
ansible-playbook main.yml --tags bootstrap --extra-vars "bootstrap_system_upgrade=true"
```
