#!/bin/bash

set -ex

BRNAME=brq$(echo $MGMT_NETWORK_ID | cut -c 1-11)

if [ "$1" == "start" ]; then
  ip link add o-hm0 type veth peer name o-bhm0
  brctl addif $BRNAME o-bhm0
  ip link set o-bhm0 up
  ip link set dev o-hm0 address $MGMT_MAC_ADDRESS
  ip link set o-hm0 up
  iptables -I INPUT -i o-hm0 -p udp --dport 5555 -j ACCEPT
  dhclient -v o-hm0 -cf /etc/dhcp/octavia.conf
elif [ "$1" == "stop" ]; then
  brctl delif $BRNAME o-bhm0
  ip link del o-hm0
else
  brctl show $BRNAME
  ip a s dev o-hm0
fi
