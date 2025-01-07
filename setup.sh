#!/usr/bin/env bash

ROOT_DIR="/mnt/x/important/sys-diplom"

cd $ROOT_DIR/terraform
terraform apply -auto-approve

BASTION_IP=$(terraform output -raw bastion_ip)

if [ -z "$BASTION_IP" ]; then
  echo "Не удалось получить внешний IP хоста Bastion"
  exit 1
fi

cd $ROOT_DIR/ansible
cat > inventory.ini <<EOL
[bastion-proxy]
bastion.ru-central1.internal ansible_host=$BASTION_IP

[bastion-proxy:vars]
ansible_user=external
ansible_ssh_private_key_file=../terraform/private/external
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

[internal]
web-server-1.ru-central1.internal
web-server-2.ru-central1.internal
zabbix.ru-central1.internal
kibana.ru-central1.internal
elastic.ru-central1.internal

[internal:vars]
ansible_ssh_common_args='-o ProxyCommand="ssh -i ../terraform/private/external -W %h:%p external@$BASTION_IP"'
ansible_user=internal
ansible_ssh_private_key_file=../terraform/private/internal
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOL

ansible-playbook -i ./inventory.ini ./playbooks/ping.yml -e ansible_remote_tmp=/tmp/.ansible/tmp
