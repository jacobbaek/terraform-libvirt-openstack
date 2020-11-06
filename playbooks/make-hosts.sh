#!/bin/bash

# make hosts.ini
#scp ~/.ssh/id_rsa centos@192.168.201.5://home/centos/.ssh/

storage_net=`cat ../variables.tf | grep -A 1 storage | grep -E "([0-9]{1,3}[\.]){2}[0-9]{1,3}" | awk -F'\"' '{print $2}'`
monitor_net=`cat ../variables.tf | grep -A 1 monitor | grep -E "([0-9]{1,3}[\.]){2}[0-9]{1,3}" | awk -F'\"' '{print $2}'`
internal_net=`cat ../variables.tf | grep -A 1 internal | grep -E "([0-9]{1,3}[\.]){2}[0-9]{1,3}" | awk -F'\"' '{print $2}'`
deploy_net=`cat ../variables.tf | grep -A 1 deploy | grep -E "([0-9]{1,3}[\.]){2}[0-9]{1,3}" | awk -F'\"' '{print $2}'`
external_net=`cat ../variables.tf | grep -A 1 external | grep -E "([0-9]{1,3}[\.]){2}[0-9]{1,3}" | awk -F'\"' '{print $2}'`
osp_ip=`cat ../variables.tf | grep -A 1 osp-ipnum | grep -E "[0-9]" | awk -F'\"' '{print $2}'`
ceph_ip=`cat ../variables.tf | grep -A 1 ceph-ipnum | grep -E "[0-9]" | awk -F'\"' '{print $2}'`
deploy_ip=`cat ../variables.tf | grep -A 1 deploy-ipnum | grep -E "[0-9]" | awk -F'\"' '{print $2}'`
ceph_count=`cat ../variables.tf | grep -A 2 ceph-names | grep "default" | awk -F',' '{print NF}'`
osp_count=`cat ../variables.tf | grep -A 2 osp-names | grep "default" | awk -F',' '{print NF}'`
ceph_num=`expr $ceph_count - 1`
osp_num=`expr $osp_count - 1`

for i in `seq 0 $osp_num`; do
    echo "kolla-ctrl00"$i"   ansible_host=${deploy_net}.${osp_ip}"$i
done
for i in `seq 0 $ceph_num`; do
    echo "kolla-ceph00"$i"   ansible_host=${deploy_net}.${ceph_ip}"$i
done
