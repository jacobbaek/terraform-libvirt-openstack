### Common

variable "project-name" {
  default = "jacobbaek"
}

variable "control-names" {
  type = list(string)
  default = ["ctrl001","ctrl002","ctrl003"]
  #default = []
}

variable "compute-names" {
  type = list(string)
  default = ["com001","com002","com003"]
  #default = []
}

variable "ceph-names" {
  type = list(string)
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

# will be x.x.x.5
variable "deploy-ipnum" {
  default = "5"
}

# will be x.x.x.10 ~
variable "control-ipnum" {
  default = "1"
}

# will be x.x.x.20 ~
variable "compute-ipnum" {
  default = "2"
}

# will be x.x.x.30 ~
variable "ceph-ipnum" {
  default = "3"
}

### Storage

variable "disk_pool" {
  default = "default"
}

variable "fromdisk" {
  #default = "centos7.qcow2"
  default = "CentOS-7-x86_64-GenericCloud.qcow2"
}
