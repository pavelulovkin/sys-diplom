#
resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    core_fraction = 20
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8kq3kltlbmh6m9r2o1"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_nat.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("./private/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "web-server" {
  count       = 2
  name        = "web-${count.index}"
  hostname    = "web-${count.index}"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    core_fraction = 20
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8da1ec4k7t2hjaob7c"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-private.id
  }
  metadata = {
    ssh-keys = "${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "zabbix-web" {
    name        = "zabbix-web"

}

resource "yandex_compute_instance" "zabbix-server" {
    name        = "zabbix-server"
}

resource "yandex_compute_instance" "kibana" {
    name        = "kibana"
}

resource "yandex_compute_instance" "elastic" {
    name        = "elastic"
}