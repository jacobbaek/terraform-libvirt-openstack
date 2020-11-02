#!/bin/bash

CURUSER="centos"
INITSTART=0

# make hosts.ini
cat 


if [ $INITSTART -eq 1 ]; then
  for ip in `cat hosts.ini | grep ansible_host | awk '{print $2}' | awk -F'=' '{print $2}'`; do
    ssh-copy-id $CURUSER@$ip
  done
fi

#ansible-playbook -i hosts.ini playbook.yaml
