# Known issues

## Horizon shows server error after installing magnum, trove or designate

Run ´chmod o+r /usr/share/openstack-dashboard/openstack_dashboard/local/enabled/*.py` on Horizon host.

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

Link to : https://ask.openstack.org/en/question/128391/magnum-ussuri-container-not-booting-up/
