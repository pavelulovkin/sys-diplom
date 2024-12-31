resource "yandex_lb_network_load_balancer" "web-balancer" {
  name = "web-balancer"

  listener {
    name = "http"
    port = 80
    protocol = "http"
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web-servers.id
    healthcheck {
      http_options {
        path = "/"
        port = 80
      }
    }
  }
}

resource "yandex_lb_target_group" "web-servers" {
  name = "web-servers-target-group"

  target {
    instance_id = yandex_compute_instance.web-server[0].id
    address     = "10.0.2.4"
  }

  target {
    instance_id = yandex_compute_instance.web-server[1].id
    address     = "10.0.2.5"
  }
}