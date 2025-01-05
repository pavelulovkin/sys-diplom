output "network_id" {
  value = yandex_vpc_network.network.id
}

output "subnet_nat_id" {
  value = yandex_vpc_subnet.subnet_public.id
}

output "subnet_private_id" {
  value = yandex_vpc_subnet.subnet_private.id
}
