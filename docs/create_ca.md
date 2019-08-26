# Create CA

```sh
mkdir -p /etc/openstack-ca/private /etc/openstack-ca/certs
openssl genrsa -aes256 -out /etc/openstack-ca/private/ca.key 4096
chmod 600 /etc/openstack-ca/private/ca.key
openssl req -x509 -new -nodes -extensions v3_ca -key /etc/openstack-ca/private/ca.key -days 1095 -out /etc/openstack-ca/certs/ca.crt -sha512
```
