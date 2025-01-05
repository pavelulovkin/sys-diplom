resource "yandex_vpc_network" "network" {
  name = var.NETWORK_NAME
}

resource "yandex_vpc_subnet" "subnet_public" {
  name           = "subnet-nat"
  zone           = var.ZONE
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.SUBNET_PUBLIC_CIDR]
}

resource "yandex_vpc_subnet" "subnet_private" {
  name           = "subnet-private"
  zone           = var.ZONE
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.SUBNET_PRIVATE_CIDR]
}

resource "yandex_vpc_nat_gateway" "gateway" {
  name       = "gateway"
  network_id = yandex_vpc_network.network.id
  subnet_ids = [yandex_vpc_subnet.subnet_public.id]
}