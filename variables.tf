### Common

variable "project-name" {
  default = "jacobbaek"
}

variable "control-names" {
  type = list(string)
  #default = ["ctrl001","ctrl002","ctrl003"]
  default = []
}

variable "compute-names" {
  type = list(string)
  #default = ["com001","com002"]
  default = []
}

variable "ceph-names" {
  type = list(string)
  #default = ["ceph001","ceph002","ceph003"]
  default = ["ceph001","ceph002","ceph003"]
}

variable "deploy-name" {
  default = "deploy"
}

### Network 

variable "deploy-addr" {
  default = "10.10.10"
}

variable "internal-addr" {
  default = "20.20.20"
}

variable "storage-addr" {
  default = "30.30.30"
}

variable "monitor-addr" {
  default = "40.40.40"
}

variable "external-addr" {
  default = "172.16.100"
}

variable "external-net" {
  default = "172.16.100.0/24"
}

# will be x.x.x.99
variable "deploy-ipnum" {
  default = "99"
}

# will be x.x.x.110 ~
variable "control-ipnum" {
  default = "11"
}

# will be x.x.x.120 ~
variable "compute-ipnum" {
  default = "12"
}

# will be x.x.x.130 ~
variable "ceph-ipnum" {
  default = "13"
}

### Storage

variable "disk_pool" {
  default = "default"
}

variable "vm_source" {
  default = "/var/lib/libvirt/images/CentOS7-1901.qcow2"
}

variable "fromdisk" {
  default = "centos8.qcow2"
}
