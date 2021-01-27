resource "libvirt_cloudinit_disk" "cephcloudinit" {
  count = length(var.ceph-names)
  pool = var.disk_pool

  name = "${var.project-name}-ceph-cloudinit${count.index}.iso"
  user_data = data.template_file.user_data[count.index].rendered
  meta_data = data.template_file.ceph_metadata[count.index].rendered
  network_config = data.template_file.ceph_network_config[count.index].rendered
}

resource "libvirt_domain" "ceph-instances" {
  count = length(var.ceph-names)

  name = format("%s-%s", var.project-name, element(var.ceph-names, count.index))
  memory = "4096"
  vcpu = 2

  cloudinit = libvirt_cloudinit_disk.cephcloudinit[count.index].id

  disk {
    volume_id = libvirt_volume.cephroot[count.index].id
  }

  disk {
    volume_id = libvirt_volume.osd0[count.index].id
  }

  disk {
    volume_id = libvirt_volume.osd1[count.index].id
  }

  disk {
    volume_id = libvirt_volume.osd2[count.index].id
  }

  # deploy network
  network_interface {
    network_id = libvirt_network.deploy.id
    addresses = ["${var.deploy-addr}.${var.ceph-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage monitor network
  network_interface {
    network_id = libvirt_network.monitor.id
    addresses = ["${var.monitor-addr}.${var.ceph-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # storage network
  network_interface {
    network_id = libvirt_network.storage.id
    addresses = ["${var.storage-addr}.${var.ceph-ipnum}${count.index}"]
    wait_for_lease = false
  }

  # external network
  network_interface {
    #network_name = "${var.project-name}-external"
    network_name = "default"
    addresses = ["${var.external-addr}.${var.ceph-ipnum}${count.index}"]
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
    host = "${var.external-addr}.${var.ceph-ipnum}${count.index}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "yum install -y qemu-guest-agent"
    ]
  }
}
