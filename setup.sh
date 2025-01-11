#!/usr/bin/env bash
if ansible-galaxy collection list | grep -q 'community.zabbix'; then
  echo "Коллекция community.zabbix установлена."
else
  ansible-galaxy collection install community.zabbix
fi


ROOT_DIR="/mnt/x/important/sys-diplom"
API_KEY="85z9s2uP1Zx3H8JY7xIsa611AT3xFo"

cd $ROOT_DIR/terraform
terraform plan
terraform apply -auto-approve

BALANCER_IP=$(terraform output -raw load_balancer_ip)
BASTION_IP=$(terraform output -raw bastion_ip)
ZABBIX_INTERNAL_IP=$(terraform output -raw zabbix_internal_ip)
declare -A dns_records

if [ -z "$BASTION_IP" ]; then
  echo "Не удалось получить внешний IP хоста Bastion"
  exit 1
fi
if [ -z "$ZABBIX_INTERNAL_IP" ]; then
  echo "Не удалось получить внутренний IP zabbix-server"
  exit 1
fi

# dns_records['sys34-ulovkinp.run.place']=$BALANCER_IP
# dns_records['zabbix.sys34-ulovkinp.run.place']=$BASTION_IP
# dns_records['kibana.sys34-ulovkinp.run.place']=$BASTION_IP

# cd $ROOT_DIR
# for NAME in "${!dns_records[@]}"; do
#     IP="${dns_records[$NAME]}"
#     cat <<EOF > ./update.json
# {
#     "update": {
#         "type": "A",
#         "name": "$NAME",
#         "content": "$IP",
#         "ttl": 5
#     }
# }
# EOF
#     cat ./update.json
#     curl "https://api.dnsexit.com/dns/ud/?apikey=$API_KEY&host=$NAME&ip=$IP"
# done

cd $ROOT_DIR/ansible
sed "s/BASTION_IP/$BASTION_IP/g" ./templates/inventory_template.ini > ./inventory.ini
sed -i "s/^zabbix_internal_ip:.*/zabbix_internal_ip: \"$ZABBIX_INTERNAL_IP\"/" ./private/vars.yml

export ANSIBLE_CONFIG="./ansible.cfg"

ansible-playbook -i ./inventory.ini ./playbooks/main.yml -e ansible_remote_tmp=/tmp/.ansible/tmp

