# It can not make, if you use the duplicated bridge name or network name or addresses.

resource "libvirt_network" "deploy" {
  name = "${var.project-name}-deploy"
  mode = "none"
  bridge = "virbr${var.deploy-ipnum}0"
  addresses = ["${var.deploy-addr}.0/24"]
  autostart = true
}

resource "libvirt_network" "storage" {
  name = "${var.project-name}-storage"
  mode = "none"
  bridge = "virbr${var.deploy-ipnum}1"
  addresses = ["${var.storage-addr}.0/24"]
  autostart = true
}

resource "libvirt_network" "monitor" {
  name = "${var.project-name}-monitor"
  mode = "none"
  bridge = "virbr${var.deploy-ipnum}2"
  addresses = ["${var.monitor-addr}.0/24"]
  autostart = true
}

resource "libvirt_network" "internal" {
  name = "${var.project-name}-internal"
  mode = "none"
  bridge = "virbr${var.deploy-ipnum}3"
  addresses = ["${var.internal-addr}.0/24"]
  autostart = true
}

## will make nat network and this can not access from external network.
#resource "libvirt_network" "external" {
#  name = "${var.project-name}-external"
#  mode = "nat"
#  addresses = [var.external-net]
#  autostart = true
#}

# below resource have defined bridge.
#resource "libvirt_network" "external" {
#  name = "${var.project-name}-external"
#  mode = "bridge"
#  bridge = "br0"
#  addresses = [var.external-net]
#  autostart = true
#}
