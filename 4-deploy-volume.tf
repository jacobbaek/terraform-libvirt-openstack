resource "libvirt_volume" "deployroot" {
  name = "${var.project-name}-deployroot"
  base_volume_pool = var.disk_pool
  pool = var.disk_pool
  format = "qcow2"
  base_volume_name = var.fromdisk
}

resource "libvirt_volume" "deploydisk" {
  name = "${var.project-name}-deploydisk"
  pool = var.disk_pool
  size = 10000000000
}

