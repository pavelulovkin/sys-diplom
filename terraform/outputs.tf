output "bastion_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}
output "zabbix_internal_ip" {
  value = yandex_compute_instance.zabbix.network_interface[0].ip_address
}