#
resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  platform_id     = var.platform_id
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_public.id
    nat       = true
  }
  metadata = {
    user-data = templatefile("${path.module}/user-data.tpl", {
      username = "external"
      ssh_key  = file("./private/external.pub")
    })
  }
}

resource "yandex_compute_instance" "web-server" {
  count       = 2
  name        = "web-${count.index}"
  platform_id     = var.platform_id
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_private.id
  }
  metadata = {
    ssh-keys = "${file("./private/internal.pub")}"
  }
}

resource "yandex_compute_instance" "zabbix-web" {
  name        = "zabbix-web"
  platform_id     = var.platform_id
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_public.id
  }
}

resource "yandex_compute_instance" "zabbix-server" {
  name        = "zabbix-server"
  platform_id     = var.platform_id
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_private.id
  }
}

resource "yandex_compute_instance" "kibana" {
  name        = "kibana"
  platform_id     = var.platform_id
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_public.id
  }
}

resource "yandex_compute_instance" "elastic" {
  name            = "elastic"
  platform_id     = var.platform_id
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_private.id
  }
}