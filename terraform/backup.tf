resource "yandex_compute_snapshot_schedule" "snapshot_schedule" {
  name           = "snapshot-schedule"
  schedule_policy {
    expression = "0 0 * * *"
  }
  disk_ids = [
    yandex_compute_instance.bastion.boot_disk[0].disk_id,
    yandex_compute_instance.web-server[0].boot_disk[0].disk_id,
    yandex_compute_instance.web-server[1].boot_disk[0].disk_id,
    yandex_compute_instance.zabbix.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id,
    yandex_compute_instance.elastic.boot_disk[0].disk_id
  ]
  depends_on = [
    yandex_compute_instance.bastion,
    yandex_compute_instance.web-server,
    yandex_compute_instance.zabbix,
    yandex_compute_instance.kibana,
    yandex_compute_instance.elastic
  ]
  retention_period = "168h"
  labels = {
    environment = "sys34"
  }
}