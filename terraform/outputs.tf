output "bastion_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}
output "load_balancer_ip" {
  value = yandex_alb_load_balancer.load_balancer_web.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
  description = "The external IP address of the load balancer"
}
output "zabbix_internal_ip" {
  value = yandex_compute_instance.zabbix.network_interface[0].ip_address
}
