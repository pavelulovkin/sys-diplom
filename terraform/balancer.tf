resource "yandex_alb_target_group" "tg_web-servers" {
  name = "tg-web-servers"
  dynamic "target" {
    for_each          = yandex_compute_instance.web-server
    content {
      subnet_id       = yandex_vpc_subnet.subnet_private_web[target.key].id
      ip_address      = target.value.network_interface[0].ip_address
    }
  }
}

resource "yandex_alb_backend_group" "backend_group" {
  name = "backend-group"
  http_backend {
    name              = "backend-web"
    port              = 80
    target_group_ids  = [yandex_alb_target_group.tg_web-servers.id]
    healthcheck {
      timeout         = "5s"
      interval        = "60s"
      http_healthcheck {
        path          = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "router_web" {
  name                = "router-web"
}

resource "yandex_alb_virtual_host" "virtual_host_web" {
  name                = "virtual-host-web"
  http_router_id      = yandex_alb_http_router.router_web.id
  route {
    name = "route-main"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend_group.id
        timeout          = "5s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "load_balancer_web" {
  name               = "load-balancer-web"
  network_id         = yandex_vpc_network.network_cloud.id
  security_group_ids = [yandex_vpc_security_group.rule_load_balancer.id, yandex_vpc_security_group.rule_internal.id] 
  allocation_policy {
    location {
      zone_id   = var.YC_ZONES[0]
      subnet_id = yandex_vpc_subnet.subnet_public.id
    }
  }
  listener {
    name = "listener-web"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.router_web.id
      }
    }
  }
}