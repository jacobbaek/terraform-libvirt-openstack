resource "libvirt_volume" "osproot" {
  count = length(var.osp-names)
  name = "${var.project-name}-osproot-${count.index}"
  base_volume_pool = var.disk_pool
  pool = var.disk_pool
  format = "qcow2"
  base_volume_name = var.fromdisk
}

resource "libvirt_volume" "ospdisk" {
  count = length(var.osp-names)
  name = "${var.project-name}-ospdisk-${count.index}"
  pool = var.disk_pool
  size = 10000000000
}
