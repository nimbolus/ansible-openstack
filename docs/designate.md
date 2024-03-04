# Designate

## TSIG Key Authentication

It's highly recommended to setup TSIG key authentication for the default pool.

1. Fetch generated TSIG key from `/etc/designate/rndc.key`
2. Add TSIG key to OpenStack database:
   ```sh
   openstack tsigkey create --name designate --algorithm hmac-md5 \
     --scope POOL --resource-id <default-pool-id>
     --secret <secret>
   ```
3. Set `designate_mdns_query_enforce_tsig` to `true`

## Multiple DNS Server Pools

Using pools beside the default pool requires TSIG key authentication to be configured.
For external nameservers a new TSIG key needs to be generated and added to the OpenStack database: `dnssec-keygen -a HMAC-SHA512 -b 512 -n HOST -r /dev/urandom <name>`

Example for multiple pools:
```yaml
designate_pools:
  - "{{designate_default_pool}}"
  - name: example
    description: example pool
    attributes:
      pool_name: example
    ns_records:
      - hostname: ns1.example.com
        priority: 1
    nameservers:
      - host: 8.8.8.8
        port: 53
    targets:
      - type: fake
        description: example
        masters:
          - host: 127.0.0.1
            port: 5354
        options:
          host: 8.8.8.8
          port: 53
```

## Known Bugs

- https://bugs.launchpad.net/designate/+bug/1986733
