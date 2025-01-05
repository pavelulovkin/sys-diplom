output "network_id" {
  value = yandex_vpc_network.network_cloud.id
}

output "subnet_public_id" {
  value = yandex_vpc_subnet.subnet_public.id
}

output "subnet_private_web_0_id" {
  value = yandex_vpc_subnet.subnet_private_web[0].id
}

output "subnet_private_web_1_id" {
  value = yandex_vpc_subnet.subnet_private_web[1].id
}

output "subnet_private_elastic_id" {
  value = yandex_vpc_subnet.subnet_private_elastic.id
}