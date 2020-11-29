# Create KVM VM using terraform 
This terraform script will be made VMs that will be made as OpenStack.

# Prerequite
Have to download terraform-provider-libvirt plugin at the following link.
* https://github.com/dmacvicar/terraform-provider-libvirt

have to copy the plugin file into .terraform.d/plugins at your home directory.

# Environment
Verified below versions
 - terraform 0.13.4
 - libvirtd 5.4.0
 - QEMU 4.0.0
 - terraform-provider-libvirt 0.6.2

# Recommended
It is better to use authentication with ssh-key.
If the using ssh-key, don't use the password.

# Terraform Output Example
```
Outputs:

ceph_instances_with_ipaddr = {
  "jacobbaek-ceph001" = []
  "jacobbaek-ceph002" = []
  "jacobbaek-ceph003" = []
}
deploy_instances_with_ipaddr = {
  "jacobbaek-deploy" = []
}
control_instances_with_ipaddr = {
  "jacobbaek-ctrl001" = []
  "jacobbaek-ctrl002" = []
  "jacobbaek-ctrl003" = []
}
compute_instances_with_ipaddr = {
  "jacobbaek-ctrl001" = []
  "jacobbaek-ctrl002" = []
  "jacobbaek-ctrl003" = []
}
```

# Don't forget this
- should use default network
- check the virbr names (if there is duplicated name, this script will be failed.)

# How to use
 0. should check and modify the variable.tf
 1. terraform init
 2. terraform plan
 3. terraform apply --auto-approve
 4. cd playbook
 5. bash get-playbooks.sh
 6. 
