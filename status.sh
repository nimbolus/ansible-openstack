#!/bin/bash

ansible controller_nodes -m shell -b -a "systemctl status openstack-glance-registry openstack-glance-api"
ansible controller_nodes -m shell -b -a "systemctl status openstack-nova-api openstack-nova-scheduler openstack-nova-conductor openstack-nova-novncproxy"
ansible network_nodes -m shell -b -a "systemctl status neutron-server neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent neutron-linuxbridge-agent"
ansible compute_nodes -m shell -b -a "systemctl status openstack-nova-compute neutron-linuxbridge-agent"
