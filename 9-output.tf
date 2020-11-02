output "osp_instances_with_ipaddr" {
  description = "openstack instances with ipaddr"
  value = zipmap(libvirt_domain.osp-instances.*.name, libvirt_domain.osp-instances[*].network_interface.4.addresses.*)
}

output "deploy_instances_with_ipaddr" {
  description = "deploy instances with ipaddr"
  value = zipmap(tolist([libvirt_domain.deploy-instance.name]), tolist([libvirt_domain.deploy-instance.network_interface.2.addresses.*]))
}

output "ceph_instances_with_ipaddr" {
  description = "Ceph instances with ipaddr"
  value = zipmap(libvirt_domain.ceph-instances.*.name, libvirt_domain.ceph-instances.*.network_interface.3.addresses[*])
}
