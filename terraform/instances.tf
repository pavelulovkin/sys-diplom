#
resource "yandex_compute_instance" "bastion" {
  name            = "bastion"
  hostname        = "bastion"
  platform_id     = var.platform_id
  scheduling_policy {
    preemptible   = var.scheduling_policy.preemptible
  }
  resources {
    cores         = var.instance_resources.cores
    core_fraction = var.instance_resources.core_fraction
    memory        = var.instance_resources.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnet_public.id
    security_group_ids = [yandex_vpc_security_group.rule_bastion.id]
    nat           = true
  }
  metadata = {
    user-data     = templatefile("${path.module}/user-data-bastion.tpl", {
      username    = "external"
      ssh_key     = file("./private/external.pub")
    })
  }
}
resource "yandex_compute_instance" "web-server" {
  count           = 2
  name            = "web-server-${count.index + 1}"
  hostname        = "web-server-${count.index + 1}"
  platform_id     = var.platform_id
  zone            = var.YC_ZONES[count.index]
  scheduling_policy {
    preemptible   = var.scheduling_policy.preemptible
  }
  resources {
    cores         = var.instance_resources.cores
    core_fraction = var.instance_resources.core_fraction
    memory        = var.instance_resources.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnet_private_web[count.index].id
    security_group_ids = [yandex_vpc_security_group.rule_internal.id, yandex_vpc_security_group.rule_web_server.id]
  }
  metadata = {
    user-data     = templatefile("${path.module}/user-data.tpl", {
      username    = "internal"
      ssh_key     = file("./private/internal.pub")
    })
  }
}

resource "yandex_compute_instance" "zabbix" {
  name            = "zabbix"
  hostname        = "zabbix"
  platform_id     = var.platform_id
  scheduling_policy {
    preemptible   = var.scheduling_policy.preemptible
  }
  resources {
    cores         = var.instance_resources.cores
    core_fraction = var.instance_resources.core_fraction
    memory        = var.instance_resources.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnet_public.id
    security_group_ids = [yandex_vpc_security_group.rule_internal.id]
  }
  metadata = {
    user-data     = templatefile("${path.module}/user-data.tpl", {
      username    = "internal"
      ssh_key     = file("./private/internal.pub")
    })
  }
}

resource "yandex_compute_instance" "kibana" {
  name            = "kibana"
  hostname        = "kibana"
  platform_id     = var.platform_id
  scheduling_policy {
    preemptible   = var.scheduling_policy.preemptible
  }
  resources {
    cores         = var.instance_resources.cores
    core_fraction = var.instance_resources.core_fraction
    memory        = var.instance_resources.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnet_public.id
    security_group_ids = [yandex_vpc_security_group.rule_internal.id]
  }
  metadata = {
    user-data     = templatefile("${path.module}/user-data.tpl", {
      username    = "internal"
      ssh_key     = file("./private/internal.pub")
    })
  }
}

resource "yandex_compute_instance" "elastic" {
  name            = "elastic"
  hostname        = "elastic"
  platform_id     = var.platform_id
  scheduling_policy {
    preemptible   = var.scheduling_policy.preemptible
  }
  resources {
    cores         = var.instance_resources.cores
    core_fraction = var.instance_resources.core_fraction
    memory        = var.instance_resources.memory
  }
  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnet_private_elastic.id
    security_group_ids = [yandex_vpc_security_group.rule_internal.id]
  }
  metadata = {
    user-data     = templatefile("${path.module}/user-data.tpl", {
      username    = "internal"
      ssh_key     = file("./private/internal.pub")
    })
  }
}