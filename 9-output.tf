output "control_instances_with_ipaddr" {
  description = "openstack control nodes's ipaddr"
  value = zipmap(libvirt_domain.control-instances.*.name, libvirt_domain.control-instances[*].network_interface.4.addresses.*)
}

output "compute_instances_with_ipaddr" {
  description = "openstack compute nodes's ipaddr"
  value = zipmap(libvirt_domain.compute-instances.*.name, libvirt_domain.compute-instances[*].network_interface.4.addresses.*)
}

output "deploy_instances_with_ipaddr" {
  description = "deploy node's ipaddr"
  value = zipmap(tolist([libvirt_domain.deploy-instance.name]), tolist([libvirt_domain.deploy-instance.network_interface.2.addresses.*]))
}

output "ceph_instances_with_ipaddr" {
  description = "Ceph node's ipaddr"
  value = zipmap(libvirt_domain.ceph-instances.*.name, libvirt_domain.ceph-instances.*.network_interface.3.addresses[*])
}
