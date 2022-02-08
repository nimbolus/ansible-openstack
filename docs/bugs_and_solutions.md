# Bugs and solutions

## Horizon shows server error after installing magnum, trove or designate

Run `chmod o+r /usr/share/openstack-dashboard/openstack_dashboard/local/enabled/*.py` on Horizon host.

## Horizon can't find jquery and angular

run on horizon host:
```
/usr/share/openstack-dashboard/manage.py collectstatic --noinput
/usr/share/openstack-dashboard/manage.py compress
systemctl restart httpd
```

## Magnum Kubernetes cluster runs into timeout (ussuri)

Error:
```log
no configuration has been provided, try setting KUBERNETES_MASTER environment variable
```

Patches:
```diff
--- /usr/lib/python3.6/site-packages/magnum/drivers/common/templates/kubernetes/fragments/enable-services-master.sh.org	2020-12-08 23:43:31.721411768 +0100
+++ /usr/lib/python3.6/site-packages/magnum/drivers/common/templates/kubernetes/fragments/enable-services-master.sh	    2020-12-08 23:42:57.903622366 +0100
@@ -2,6 +2,9 @@

 . /etc/sysconfig/heat-params

+echo 'export KUBERNETES_MASTER="http://127.0.0.1:8080"' >> /etc/environment
+. /etc/environment
+
 ssh_cmd="ssh -F /srv/magnum/.ssh/config root@localhost"

 # make sure we pick up any modified unit files
```

```diff
--- /usr/lib/python3.6/site-packages/magnum/drivers/k8s_fedora_coreos_v1/templates/kubecluster.yaml.org	2020-12-09 01:17:55.840498009 +0100
+++ /usr/lib/python3.6/site-packages/magnum/drivers/k8s_fedora_coreos_v1/templates/kubecluster.yaml	    2020-12-09 01:18:41.168847934 +0100
@@ -1287,6 +1287,8 @@
         list_join:
           - "\n"
           -
+            - "#!/bin/bash"
+            - "export KUBERNETES_MASTER=http://127.0.0.1:8080"
             - get_file: ../../common/templates/kubernetes/fragments/kube-apiserver-to-kubelet-role.sh
             - get_file: ../../common/templates/kubernetes/fragments/core-dns-service.sh
             - if:
```

See [magnum-ussuri-container-not-booting-up](https://ask.openstack.org/en/question/128391/magnum-ussuri-container-not-booting-up/) for more information.

## DNF mirrorlists are empty after upgrading to CentOS Stream

After upgrading to CenOS 8-steam (Package: `centos-release-stream`), also other `centos-release-*` packages needs to be updated:

```sh
dnf --disablerepo="*" --enablerepo="extras" update \
  centos-release-advanced-virtualization \
  centos-release-ceph-nautilus \
  centos-release-messaging \
  centos-release-nfv-common \
  centos-release-nfv-openvswitch \
  centos-release-openstack-ussuri \
  centos-release-rabbitmq-38 \
  centos-release-storage-common \
  centos-release-virt-common
```

The `centos-release-ceph-nautilius` package may has no available update. It can be fixed by manually setting the mirrorlist to `http://mirrorlist.centos.org/?release=$avstream&arch=$basearch&repo=storage-ceph-nautilus`.

This can be done with Ansible:
```sh
ansible openstack -m lineinfile -b -a 'path=/etc/yum.repos.d/CentOS-Ceph-Nautilus.repo line="mirrorlist=http://mirrorlist.centos.org/?release=$avstream&arch=$basearch&repo=storage-ceph-nautilus" regexp="^mirrorlist="'
```
