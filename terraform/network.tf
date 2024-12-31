resource "yandex_vpc_network" "network" {
  name = var.NETWORK_NAME
}

resource "yandex_vpc_subnet" "subnet-nat" {
  name           = "subnet-nat"
  zone           = var.ZONE
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.SUBNET_NAT]
}

resource "yandex_vpc_subnet" "subnet-private" {
  name           = "subnet-private"
  zone           = var.ZONE
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.SUBNET_PRIVATE]
}

resource "yandex_vpc_nat_gateway" "gateway" {
  name       = "gateway"
  network_id = yandex_vpc_network.network.id
  subnet_ids = [yandex_vpc_subnet.NAT.id]
}