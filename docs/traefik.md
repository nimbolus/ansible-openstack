# Traefik

```yaml
traefik_enabled: true
traefik_domain: cloud.example.com

httpd_listen: 127.0.0.1:8081
httpd_ssl_listen_port: 8443
httpd_ssl_redirect: false
httpd_landing_page_horizon_url: "https://horizon.{{traefik_domain}}"

keystone_url: "https://keystone.{{traefik_domain}}"
glance_url: "https://glance.{{traefik_domain}}"
cinder_url: "https://cinder.{{traefik_domain}}"
nova_url: "https://nova.{{traefik_domain}}"
placement_url: "https://placement.{{traefik_domain}}"
neutron_url: "https://neutron.{{traefik_domain}}"
heat_url: "https://heat.{{traefik_domain}}"
heat_cfn_url: "https://heat-cfn.{{traefik_domain}}"
horizon_allowed_hosts:
  - "{{ansible_nodename}}"
  - "horizon.{{traefik_domain}}"
```
