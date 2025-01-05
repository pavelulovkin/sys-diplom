#...
resource "yandex_vpc_security_group" "rule_bastion" {
  name       = "rule-bastion"
  network_id = yandex_vpc_network.network_cloud.id

  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 2222
  }

  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "rule_load_balancer" {
  name       = "rule-load-balancer"
  network_id = yandex_vpc_network.network_cloud.id

  ingress {
    protocol = "tcp"
    predefined_target = "loadbalancer_healthchecks"
  }

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
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "rule_internal" {
  name       = "rule-internal"
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