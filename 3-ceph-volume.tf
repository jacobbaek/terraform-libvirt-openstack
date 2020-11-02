resource "libvirt_volume" "cephroot" {
  count = length(var.ceph-names)
  name = "${var.project-name}-cephroot-${count.index}"
  base_volume_pool = var.disk_pool
  pool = var.disk_pool
  format = "qcow2"
  base_volume_name = var.fromdisk
}

resource "libvirt_volume" "osd0" {
  count = length(var.ceph-names)
  name = "${var.project-name}-osd0-${count.index}"
  pool = var.disk_pool
  size = 10000000000
}

resource "libvirt_volume" "osd1" {
  count = length(var.ceph-names)
  name = "${var.project-name}-osd1-${count.index}"
  pool = var.disk_pool
  size = 10000000000
}

resource "libvirt_volume" "osd2" {
  count = length(var.ceph-names)
  name = "${var.project-name}-osd2-${count.index}"
  pool = var.disk_pool
  size = 10000000000
}
