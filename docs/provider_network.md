# Manage provider networks

## Create flat provider network

```sh
openstack network create provider1 \
    --provider-network-type flat \
    --provider-physical-network <name attribute defined in neutron_provider_flat_networks list> \
    --external \
    --share
```

## Create VLAN provider network

```sh
openstack network create provider1 \
    --provider-network-type vlan \
    --provider-segment <vlan id> \
    --provider-physical-network <name attribute defined in neutron_provider_vlan_networks list> \
    --external \
    --share
```

## Create subnet for floating IPs

```sh
openstack subnet create floating-ip \
    --network provider1 \
    --gateway 192.168.100.1 \
    --subnet-range 192.168.100.0/24 \
    --no-dhcp
```
