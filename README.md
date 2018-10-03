# ansible-openstack

## Installation

    ansible-playbook main.yml --extra-vars=keystone_bootstrap=true

## Discover new compute nodes

    ansible controller -m shell -b -a 'su -s /bin/sh -c "nova-manage cell_v2 discover_hosts" nova'
