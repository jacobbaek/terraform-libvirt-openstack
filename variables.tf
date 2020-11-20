### Common

variable "project-name" {
  default = "jacobbaek"
}

variable "osp-names" {
  type = list(string)
  default = ["master001", "master002", "master003", "worker001"]
}

variable "ceph-names" {
  type = list(string)
  default = ["ceph001", "ceph002", "ceph003"]
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
  default = "192.168.201"
}

variable "external-net" {
  default = "192.168.0.0/16"
}

variable "deploy-ipnum" {
  default = "5"
}

variable "osp-ipnum" {
  default = "1"
}

variable "ceph-ipnum" {
  default = "2"
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
