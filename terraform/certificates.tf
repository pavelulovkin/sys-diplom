# resource "yandex_certificate_manager_certificate" "crt_web" {
#   name = "crt-web"
  
#   type = "managed"
  
#   domains = [
#     "sys34-ulovkinp.run.place",
#     "www.sys34-ulovkinp.run.place"
#   ]
# }
# resource "yandex_certificate_manager_certificate" "crt_zabbix" {
#   name = "crt-zabbix"
  
#   type = "managed"
  
#   domains = [
#     "zabbix.sys34-ulovkinp.run.place",
#     "www.zabbix.sys34-ulovkinp.run.place"
#   ]
# }
# resource "yandex_certificate_manager_certificate" "crt_kibana" {
#   name = "crt-kibana"
  
#   type = "managed"
  
#   domains = [
#     "example.com", # Укажите ваш домен
#     "www.example.com"
#   ]
# }