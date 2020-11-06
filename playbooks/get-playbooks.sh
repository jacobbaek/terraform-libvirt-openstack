#!/bin/bash

branch_kubespray="release-2.14"
branch_cephansible="stable-4.0.25"

# ceph-ansible
git clone https://github.com/ceph/ceph-ansible.git
cd ceph-ansible
git checkout $branch_cephansible
cd ..

# kubespray
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
git checkout $branch_kubespary
