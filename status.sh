#!/bin/bash

ansible controller_nodes -m shell -b -a "systemctl status glance-registry glance-api"
ansible controller_nodes -m shell -b -a "systemctl status nova-api nova-scheduler nova-conductor nova-novncproxy nova-consoleauth"
ansible controller_nodes -m shell -b -a "systemctl status neutron-server neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent neutron-linuxbridge-agent"
ansible compute_nodes -m shell -b -a "systemctl status nova-compute neutron-linuxbridge-agent"
