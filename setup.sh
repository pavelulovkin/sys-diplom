#!/usr/bin/env bash

ROOT_DIR="/mnt/x/important/sys-diplom"
cd $ROOT_DIR
API_KEY=$(cat ./_dns.key)

cd $ROOT_DIR/terraform
terraform plan
terraform apply -auto-approve

BALANCER_IP=$(terraform output -raw load_balancer_ip)
BASTION_IP=$(terraform output -raw bastion_ip)
ZABBIX_INTERNAL_IP=$(terraform output -raw zabbix_internal_ip)
declare -A dns_records

dns_records['sys34-ulovkinp.run.place']=$BALANCER_IP
dns_records['zabbix.sys34-ulovkinp.run.place']=$BASTION_IP
dns_records['kibana.sys34-ulovkinp.run.place']=$BASTION_IP

for NAME in "${!dns_records[@]}"; do
    IP="${dns_records[$NAME]}"
    curl -X POST "https://api.dnsexit.com/dns/ud/?apikey=$API_KEY&host=$NAME&ip=$IP" \
    -H "Content-Type: application/json" \
    --data-raw "$(cat <<EOF
{
    "update": {
        "type": "A",
        "name": "$NAME",
        "content": "$IP",
        "ttl": 480
    }
}
EOF
    )"
done

cd $ROOT_DIR/ansible
sed "s/BASTION_IP/$BASTION_IP/g" ./templates/inventory_template.ini > ./inventory.ini
sed -i "s/^zabbix_internal_ip:.*/zabbix_internal_ip: \"$ZABBIX_INTERNAL_IP\"/" ./private/vars.yml

export ANSIBLE_CONFIG="./ansible.cfg"

ansible-playbook -i ./inventory.ini ./playbooks/main.yml -e ansible_remote_tmp=/tmp/.ansible/tmp

