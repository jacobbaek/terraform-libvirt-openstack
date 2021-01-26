# refer to https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/

# for user account setting
data "template_file" "user_data" {
  count = length(var.control-names) + length(var.compute-names) + length(var.ceph-names)
  template = file("${path.module}/templates/cloud_init.cfg")
}

# for user account setting
data "template_file" "deploy_user_data" {
  template = file("${path.module}/templates/deploy_cloud_init.cfg")
}

# for Hostname setting into control nodes
data "template_file" "control_metadata" {
  count = length(var.control-names)
  template = file("${path.module}/templates/metadata.yaml")
  vars = {
    hostname = var.control-names[count.index]
  }
}

# for Hostname setting into compute nodes
data "template_file" "compute_metadata" {
  count = length(var.compute-names)
  template = file("${path.module}/templates/metadata.yaml")
  vars = {
    hostname = var.compute-names[count.index]
  }
}

# for Hostname setting
data "template_file" "ceph_metadata" {
  count = length(var.ceph-names)
  template = file("${path.module}/templates/metadata.yaml")
  vars = {
    hostname = var.ceph-names[count.index]
  }
}

# for Hostname setting
data "template_file" "deploy_metadata" {
  template = file("${path.module}/templates/metadata.yaml")
  vars = {
    hostname = var.deploy-name
  }
}

# for Network setting
data "template_file" "control_network_config" {
  count = length(var.control-names)
  template = file("${path.module}/templates/osp_network_config.cfg")

  vars = {
    deploy_addr = var.deploy-addr
    monitor_addr = var.monitor-addr
    storage_addr = var.storage-addr
    internal_addr = var.internal-addr
    external_addr = var.external-addr
    ip_num  = "${var.control-ipnum}${count.index}"
    gateway = "${var.external-addr}.1"
  }
}

# for Network setting
data "template_file" "compute_network_config" {
  count = length(var.compute-names)
  template = file("${path.module}/templates/osp_network_config.cfg")

  vars = {
    deploy_addr = var.deploy-addr
    monitor_addr = var.monitor-addr
    storage_addr = var.storage-addr
    internal_addr = var.internal-addr
    external_addr = var.external-addr
    ip_num  = "${var.compute-ipnum}${count.index}"
    gateway = "${var.external-addr}.1"
  }
}

# for Ceph Network setting
data "template_file" "ceph_network_config" {
  count = length(var.ceph-names)
  template = file("${path.module}/templates/ceph_network_config.cfg")

  vars = {
    deploy_addr = var.deploy-addr
    monitor_addr = var.monitor-addr
    storage_addr = var.storage-addr
    external_addr = var.external-addr
    ip_num  = "${var.ceph-ipnum}${count.index}"
    gateway = "${var.external-addr}.1"
  }
}

# for Deploy Network setting
data "template_file" "deploy_network_config" {
  template = file("${path.module}/templates/deploy_network_config.cfg")

  vars = {
    deploy_addr = var.deploy-addr
    monitor_addr = var.monitor-addr
    external_addr = var.external-addr
    ip_num  = var.deploy-ipnum
    gateway = "${var.external-addr}.1"
  }
}
