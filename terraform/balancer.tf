resource "yandex_alb_target_group" "tg_web-servers" {
  name = "tg-web-servers"
  dynamic "target" {
    for_each = yandex_compute_instance.web-server
    content {
      subnet_id  = yandex_vpc_subnet.subnet_private_web[target.key].id
      ip_address = target.value.network_interface[0].ip_address
    }
  }
}

resource "yandex_alb_backend_group" "backend_group" {
  name = "backend-group"
  http_backend {
    name             = "backend-web"
    port             = 80
    target_group_ids = [yandex_alb_target_group.tg_web-servers.id]
    load_balancing_config {
      panic_threshold = 80
    }
    healthcheck {
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "router_web" {
  name = "router-web"
}