# Traefik

```yaml
traefik_enabled: true
traefik_public_domain: cloud.example.com

httpd_listen: 127.0.0.1:8081
httpd_ssl_listen_port: 8443
httpd_ssl_redirect: false
httpd_landing_page_horizon_url: "https://horizon.{{traefik_public_domain}}"

keystone_url: "https://keystone.{{traefik_public_domain}}"
glance_url: "https://glance.{{traefik_public_domain}}"
cinder_url: "https://cinder.{{traefik_public_domain}}"
nova_url: "https://nova.{{traefik_public_domain}}"
nova_novnc_url: "https://nova-novnc.{{traefik_public_domain}}"
placement_url: "https://placement.{{traefik_public_domain}}"
neutron_url: "https://neutron.{{traefik_public_domain}}"
heat_url: "https://heat.{{traefik_public_domain}}"
heat_cfn_url: "https://heat-cfn.{{traefik_public_domain}}"
horizon_allowed_hosts:
  - "{{ansible_nodename}}"
  - "horizon.{{traefik_public_domain}}"
```
