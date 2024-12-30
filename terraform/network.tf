resource "yandex_vpc_network" "default" {
  name = "default-network"
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_vpc_subnet" "private_subnet" {
  name           = "private-subnet"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}