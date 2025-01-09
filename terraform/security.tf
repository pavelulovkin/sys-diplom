#...
resource "yandex_vpc_security_group" "rule_bastion" {
  name       = "rule-bastion"
  network_id = yandex_vpc_network.network_cloud.id
  ingress {
    protocol       = "icmp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
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
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}
resource "yandex_vpc_security_group" "rule_web_server" {
  name       = "rule-web-server"
  network_id = yandex_vpc_network.network_cloud.id
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
}
resource "yandex_vpc_security_group" "rule_internal" {
  name       = "rule-internal"
  network_id = yandex_vpc_network.network_cloud.id
  ingress {
    protocol       = "icmp"
    v4_cidr_blocks = ["10.0.0.0/8"]
  }
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["10.0.0.0/24"]
    port           = 22
  }
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["10.0.0.0/24"]
    from_port   = 10050
    to_port     = 10051
  }
  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "rule_internal_web" {
  name       = "rule-internal-web"
  network_id = yandex_vpc_network.network_cloud.id
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["10.0.0.0/24"]
    port           = 80
  }
}

resource "yandex_vpc_security_group" "rule_elasticsearch" {
  name       = "rule-elasticsearch"
  network_id = yandex_vpc_network.network_cloud.id
  ingress {
    protocol       = "tcp"
    v4_cidr_blocks = ["10.0.0.0/8"]
    port           = 9200
  }
}