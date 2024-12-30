resource "yandex_compute_instance" "bastion" {
  name        = "bastion-host"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8kq3kltlbmh6m9r2o1"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "web_server_1" {

}

resource "yandex_compute_instance" "web_server_2" {

}

resource "yandex_compute_instance" "zabbix_frontend" {

}

resource "yandex_compute_instance" "zabbix_backend" {

}

resource "yandex_compute_instance" "kibana" {

}

resource "yandex_compute_instance" "elastic" {

}