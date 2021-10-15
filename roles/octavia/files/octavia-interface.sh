#!/bin/bash

set -ex

BRNAME=brq$(echo $MGMT_NETWORK_ID | cut -c 1-11)
VETH_IFACE="$2"
MGMT_IFACE="$3"

if [ -z $VETH_IFACE || -z $MGMT_IFACE ]; then
  echo "no veth or mgmt interface specified"
  exit 1
fi

if [ "$1" == "start" ]; then
  if ip a | grep $VETH_IFACE; then
    echo "interface $VETH_IFACE already exists"
  else
    ip link add $MGMT_IFACE type veth peer name $VETH_IFACE
  fi
  while true; do
    # wait for bridge to come up
    ip a | grep "${BRNAME}:" && break
    sleep 10
  done
  brctl addif $BRNAME $VETH_IFACE
  ip link set $VETH_IFACE up
  ip link set dev $MGMT_IFACE address $MGMT_MAC_ADDRESS
  ip link set $MGMT_IFACE up
  iptables -I INPUT -i $MGMT_IFACE -p udp --dport 5555 -j ACCEPT
  iptables -I FORWARD -i $BRNAME -o $BRNAME -j ACCEPT
  dhclient -v $MGMT_IFACE -cf /etc/dhcp/octavia.conf
elif [ "$1" == "stop" ]; then
  brctl delif $BRNAME $VETH_IFACE
  ip link del $MGMT_IFACE
else
  brctl show $BRNAME
  ip a s dev $MGMT_IFACE
fi
