# Bugs and solutions

## Horizon can't find jquery and angular

run on horizon host:
```
/usr/share/openstack-dashboard/manage.py collectstatic --noinput
/usr/share/openstack-dashboard/manage.py compress
systemctl restart httpd
```
