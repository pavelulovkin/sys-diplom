data "yandex_compute_instance" "all_vms" {
  for_each = toset(["bastion", "web-server-1", "web-server-2", "zabbix", "kibana", "elastic"])
  name     = each.key
}

resource "yandex_compute_snapshot_schedule" "snapshot_schedule" {
  for_each       = { for instance in data.yandex_compute_instance.all_vms : instance.id => instance }
  name           = "${each.key}-snapshot-schedule"
  disk_ids       = [each.value.boot_disk.0.disk_id]
  snapshot_count = 7

  schedule_policy {
    expression = "0 0 * * *"
  }

  retention_period = "168h"

  labels = {
    environment = "sys34"
  }
}