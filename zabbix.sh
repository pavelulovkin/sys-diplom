# curl -X POST "https://zabbix.sys34-ulovkinp.run.place/api_jsonrpc.php" \
# -H "Content-Type: application/json" \
# -d '{
#     "jsonrpc": "2.0",
#     "method": "user.login",
#     "params": {
#         "username": "Admin",
#         "password": "zabbix"
#     },
#     "id": 1
# }'

curl -X POST "https://zabbix.sys34-ulovkinp.run.place/api_jsonrpc.php" \
-H "Content-Type: application/json" -H "Authorization: Bearer 4e5ce135eb1bdd9e1e02b85b7e8ac653" \
-d '{
    "jsonrpc": "2.0",
    "method": "template.get",
    "params": {
        "output": ["hostid"],
        "selectTemplateGroups": "extend",
        "filter": {
            "host": [
                "Nginx by Zabbix agent"
            ]
        }
    },
    "id": 1
}'