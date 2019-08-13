# Ceph

```sh
ceph osd pool create cinder 128
rbd pool init cinder
ceph auth get-or-create client.cinder mon 'profile rbd' osd 'profile rbd pool=cinder'
```

Show volumes with: `rbd ls cinder`
