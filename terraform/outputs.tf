output "network_id" {
  value = yandex_vpc_network.network.id
}

output "subnet_nat_id" {
  value = yandex_vpc_subnet.subnet-nat.id
}

output "subnet_private_id" {
  value = yandex_vpc_subnet.subnet-private.id
}