resource "yandex_lb_network_load_balancer" "lb_web-servers" {
  name = "lb_web-servers"

  listener {
    name = "http"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lb_tg_web-servers.id
    healthcheck {
      name = "http-healthcheck"
      http_options {
        path = "/"
        port = 80
      }
    }
  }
}

resource "yandex_lb_target_group" "lb_tg_web-servers" {
  name = "web-servers-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.web-server[*].network_interface[0].ip_address
    content {
      address   = target.value
      subnet_id = yandex_vpc_subnet.subnet_private.id
    }
  }
}