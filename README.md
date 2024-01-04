# ansible-openstack

## Requirements

Install Ansible collections:

```sh
ansible-galaxy install -r requirements.yml
```

Generate secrets by run ansible locally:

```sh
ansible localhost -m template -a "src=secrets.yml.j2 dest=secrets.yml"
```

Next create certificate authority and save the key at `/etc/openstack-ca/private/ca.key`
and the certificate at `/etc/openstack-ca/certs/ca.crt` on the ca node. This can be done manually or
with the `copy_ca.yml` playbook. Remember to use the passphrase from `secrets_ca_key_pass` to encrypt the key.

```sh
ansible-playbook copy_ca.yml --extra-vars "ca_cert_path=./my-ca.crt ca_key_path=./my-ca.key"
```

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
```

This will install the new package repository.
Next upgrade OpenStack and run the database migrations for the new release by executing:

```sh
ansible-playbook main.yml --extra-vars "package_state=latest" --tags openstack
```

Upgrade all other packages and restart at least `httpd`:

```sh
ansible-playbook main.yml --tags bootstrap --extra-vars "bootstrap_system_upgrade=true"
ansible controller_nodes -m systemd -b -a "name=httpd state=restarted"
```

Finally remove the old package repository:

```
sudo dnf repository-packages centos-openstack-ussuri remove-or-reinstall
sudo dnf remove centos-release-openstack-ussuri
```
