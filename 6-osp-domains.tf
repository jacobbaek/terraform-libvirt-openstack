resource "libvirt_cloudinit_disk" "control-cloudinit" {
  count = length(var.control-names)
  pool = var.disk_pool

  name = "${var.project-name}-control-cloudinit${count.index}.iso"
  user_data = data.template_file.user_data[count.index].rendered
  meta_data = data.template_file.control_metadata[count.index].rendered
  network_config = data.template_file.control_network_config[count.index].rendered
}

resource "libvirt_cloudinit_disk" "compute-cloudinit" {
  count = length(var.compute-names)
  pool = var.disk_pool

  name = "${var.project-name}-compute-cloudinit${count.index}.iso"
  user_data = data.template_file.user_data[count.index].rendered
  meta_data = data.template_file.compute_metadata[count.index].rendered
  network_config = data.template_file.compute_network_config[count.index].rendered
}

resource "libvirt_domain" "control-instances" {
  count = length(var.control-names)

  name = format("%s-%s", var.project-name, element(var.control-names, count.index))
  memory = "8192"
  vcpu = 4
  cloudinit = libvirt_cloudinit_disk.control-cloudinit[count.index].id

  disk {
    volume_id = libvirt_volume.control-root[count.index].id
  }
  
  disk {
    volume_id = libvirt_volume.control-disk[count.index].id
  }

  # deploy network
  network_interface {
    network_id = libvirt_network.deploy.id
    addresses = ["${var.deploy-addr}.${var.control-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage monitor network
  network_interface {
    network_id = libvirt_network.monitor.id
    addresses = ["${var.monitor-addr}.${var.control-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage network
  network_interface {
    network_id = libvirt_network.storage.id
    addresses = ["${var.storage-addr}.${var.control-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # internal api network
  network_interface {
    network_id = libvirt_network.internal.id
    addresses = ["${var.internal-addr}.${var.control-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # external network
  network_interface {
    #network_name = "${var.project-name}-external"
    network_name = "default"
    addresses = ["${var.external-addr}.${var.control-ipnum}${count.index}"]
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
    host = "${var.external-addr}.${var.control-ipnum}${count.index}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "yum install -y qemu-guest-agent"
    ]
  }
}

resource "libvirt_domain" "compute-instances" {
  count = length(var.compute-names)

  name = format("%s-%s", var.project-name, element(var.compute-names, count.index))
  memory = "8192"
  vcpu = 4
  cloudinit = libvirt_cloudinit_disk.compute-cloudinit[count.index].id

  disk {
    volume_id = libvirt_volume.compute-root[count.index].id
  }
  
  disk {
    volume_id = libvirt_volume.compute-disk[count.index].id
  }

  # deploy network
  network_interface {
    network_id = libvirt_network.deploy.id
    addresses = ["${var.deploy-addr}.${var.compute-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage monitor network
  network_interface {
    network_id = libvirt_network.monitor.id
    addresses = ["${var.monitor-addr}.${var.compute-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage network
  network_interface {
    network_id = libvirt_network.storage.id
    addresses = ["${var.storage-addr}.${var.compute-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # internal api network
  network_interface {
    network_id = libvirt_network.internal.id
    addresses = ["${var.internal-addr}.${var.compute-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # external network
  network_interface {
    #network_name = "${var.project-name}-external"
    network_name = "default"
    addresses = ["${var.external-addr}.${var.compute-ipnum}${count.index}"]
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
    host = "${var.external-addr}.${var.compute-ipnum}${count.index}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "yum install -y qemu-guest-agent"
    ]
  }
}
