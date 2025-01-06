resource "yandex_vpc_network" "network_cloud" {
  name = "network-cloud"
}

resource "yandex_vpc_subnet" "subnet_public" {
  name           = "subnet-public"
  zone           = var.YC_ZONES[0]
  network_id     = yandex_vpc_network.network_cloud.id
  route_table_id = yandex_vpc_route_table.nat_route.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}
resource "yandex_vpc_subnet" "subnet_private_elastic" {
  name           = "subnet-private-elastic"
  zone           = var.YC_ZONES[0]
  network_id     = yandex_vpc_network.network_cloud.id
  route_table_id = yandex_vpc_route_table.nat_route.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}
resource "yandex_vpc_subnet" "subnet_private_web" {
  count       = 2
  name        = "subnet-private-web-${count.index + 1}"
  zone        = var.YC_ZONES[count.index % length(var.YC_ZONES)]
  network_id  = yandex_vpc_network.network_cloud.id
  route_table_id = yandex_vpc_route_table.nat_route.id
  v4_cidr_blocks = ["10.2.${count.index}.0/24"]
}
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}
}
resource "yandex_vpc_route_table" "nat_route" {
  name           = "nat-route"
  network_id = yandex_vpc_network.network_cloud.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id   = yandex_vpc_gateway.nat_gateway.id
  }
}