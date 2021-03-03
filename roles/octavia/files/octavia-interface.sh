#!/bin/bash

set -ex

BRNAME=brq$(echo $MGMT_NETWORK_ID | cut -c 1-11)
IFACE="o-bhm0"

if [ "$1" == "start" ]; then
  if ip a | grep $IFACE; then
    echo "interface $IFACE already exists"
  else
    ip link add o-hm0 type veth peer name $IFACE
  fi
  while true; do
    # wait for bridge to come up
    ip a | grep "${BRNAME}:" && break
    sleep 10
  done
  brctl addif $BRNAME $IFACE
  ip link set $IFACE up
  ip link set dev o-hm0 address $MGMT_MAC_ADDRESS
  ip link set o-hm0 up
  iptables -I INPUT -i o-hm0 -p udp --dport 5555 -j ACCEPT
  dhclient -v o-hm0 -cf /etc/dhcp/octavia.conf
elif [ "$1" == "stop" ]; then
  brctl delif $BRNAME $IFACE
  ip link del o-hm0
else
  brctl show $BRNAME
  ip a s dev o-hm0
fi
