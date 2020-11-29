# control node's disk
resource "libvirt_volume" "control-root" {
  count = length(var.control-names)
  name = "${var.project-name}-control-root-${count.index}"
  base_volume_pool = var.disk_pool
  pool = var.disk_pool
  format = "qcow2"
  base_volume_name = var.fromdisk
}

resource "libvirt_volume" "control-disk" {
  count = length(var.control-names)
  name = "${var.project-name}-control-disk-${count.index}"
  pool = var.disk_pool
  size = 10000000000
}

# compute node's disk
resource "libvirt_volume" "compute-root" {
  count = length(var.compute-names)
  name = "${var.project-name}-compute-root-${count.index}"
  base_volume_pool = var.disk_pool
  pool = var.disk_pool
  format = "qcow2"
  base_volume_name = var.fromdisk
}

resource "libvirt_volume" "compute-disk" {
  count = length(var.compute-names)
  name = "${var.project-name}-compute-disk-${count.index}"
  pool = var.disk_pool
  size = 10000000000
}
