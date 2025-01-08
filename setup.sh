#!/usr/bin/env bash

ROOT_DIR="/mnt/x/important/sys-diplom"

cd $ROOT_DIR/terraform
terraform plan
terraform apply -auto-approve

BASTION_IP=$(terraform output -raw bastion_ip)
ZABBIX_INTERNAL_IP=$(terraform output -raw zabbix_internal_ip)

if [ -z "$BASTION_IP" ]; then
  echo "Не удалось получить внешний IP хоста Bastion"
  exit 1
fi
if [ -z "$ZABBIX_INTERNAL_IP" ]; then
  echo "Не удалось получить внутренний IP zabbix-server"
  exit 1
fi

cd $ROOT_DIR/ansible
sed "s/BASTION_IP/$BASTION_IP/g" ./templates/inventory_template.ini > ./inventory.ini
sed -i "s/^zabbix_internal_ip:.*/zabbix_internal_ip: \"$ZABBIX_INTERNAL_IP\"/" ./private/vars.yml

export ANSIBLE_CONFIG="./ansible.cfg"

# ansible-playbook -i ./inventory.ini ./playbooks/ping.yml -e ansible_remote_tmp=/tmp/.ansible/tmp
# ansible-playbook -i ./inventory.ini ./playbooks/zabbix-server.yml -e ansible_remote_tmp=/tmp/.ansible/tmp
# ansible-playbook -i ./inventory.ini ./playbooks/bastion-web.yml -e ansible_remote_tmp=/tmp/.ansible/tmp
ansible-playbook -i ./inventory.ini ./playbooks/web-servers.yml -e ansible_remote_tmp=/tmp/.ansible/tmp