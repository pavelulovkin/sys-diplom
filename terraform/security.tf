#...
resource "yandex_vpc_security_group" "rules_load_balancer" {
  name       = "rules-load-balancer"
  network_id = yandex_vpc_network.network_cloud.id

  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "icmp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "any"
    description    = "allow any outgoing connection"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "rules_internal" {
  name       = "rules-internal"
  network_id = yandex_vpc_network.network_cloud.id

  ingress {
    protocol       = "any"
    v4_cidr_blocks = ["10.0.0.0/24", "10.1.0.0/24", "10.2.0.0/16"]
  }

  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}