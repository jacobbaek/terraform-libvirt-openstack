resource "libvirt_cloudinit_disk" "ospcloudinit" {
  count = length(var.osp-names)
  pool = var.disk_pool

  name = "${var.project-name}-osp-cloudinit${count.index}.iso"
  user_data = data.template_file.user_data[count.index].rendered
  meta_data = data.template_file.osp_metadata[count.index].rendered
  network_config = data.template_file.osp_network_config[count.index].rendered
}

resource "libvirt_domain" "osp-instances" {
  count = length(var.osp-names)

  name = format("%s-%s", var.project-name, element(var.osp-names, count.index))
  memory = "8192"
  vcpu = 4
  cloudinit = libvirt_cloudinit_disk.ospcloudinit[count.index].id

  disk {
    volume_id = libvirt_volume.osproot[count.index].id
  }
  
  disk {
    volume_id = libvirt_volume.ospdisk[count.index].id
  }

  # deploy network
  network_interface {
    network_id = libvirt_network.deploy.id
    addresses = ["${var.deploy-addr}.${var.osp-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage monitor network
  network_interface {
    network_id = libvirt_network.monitor.id
    addresses = ["${var.monitor-addr}.${var.osp-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage network
  network_interface {
    network_id = libvirt_network.storage.id
    addresses = ["${var.storage-addr}.${var.osp-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # internal api network
  network_interface {
    network_id = libvirt_network.internal.id
    addresses = ["${var.internal-addr}.${var.osp-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # external network
  network_interface {
    network_name = "${var.project-name}-external"
    addresses = ["${var.external-addr}.${var.osp-ipnum}${count.index}"]
    wait_for_lease = false
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

  connection {
    type = "ssh"
    user = "root"
    password = "root123"
    host = "${var.external-addr}.${var.osp-ipnum}${count.index}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "yum install -y qemu-guest-agent vim"
    ]
  }
}
