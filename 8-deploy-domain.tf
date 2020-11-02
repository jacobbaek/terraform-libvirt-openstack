resource "libvirt_cloudinit_disk" "deploy-cloudinit" {
  pool = "default"

  name = "${var.project-name}-deploy-cloudinit.iso"
  user_data = data.template_file.user_data[length(var.osp-names)+length(var.ceph-names)].rendered
  meta_data = data.template_file.deploy_metadata.rendered
  network_config = data.template_file.deploy_network_config.rendered
}

resource "libvirt_domain" "deploy-instance" {
  name = format("%s-%s", var.project-name, "deploy")
  memory = "8192"
  vcpu = 4

  cloudinit = libvirt_cloudinit_disk.deploy-cloudinit.id

  disk {
    volume_id = libvirt_volume.deployroot.id
  }

  disk {
    volume_id = libvirt_volume.deploydisk.id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }

  # deploy network
  network_interface {
    network_id = libvirt_network.deploy.id
    addresses = ["${var.deploy-addr}.${var.deploy-ipnum}"]
    wait_for_lease = false
  }

  # storage network
  network_interface {
    network_id = libvirt_network.storage.id
    addresses = ["${var.storage-addr}.${var.deploy-ipnum}"]
    wait_for_lease = false
  }

  # external network
  network_interface {
    network_name = "${var.project-name}-external"
    addresses = ["${var.external-addr}.${var.deploy-ipnum}"]
    wait_for_lease = false
  }

  connection {
    type = "ssh"
    user = "root"
    password = "root123"
    host = "${var.external-addr}.${var.deploy-ipnum}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "yum install -y qemu-guest-agent vim net-tools"
    ]
  }
}
