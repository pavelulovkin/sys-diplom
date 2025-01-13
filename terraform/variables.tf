variable "YC_TOKEN" {
  description = "API токен Yandex Cloud"
  type        = string
  sensitive   = true
}
variable "YC_CLOUD_ID" {
  description = "Идентификатор облака Yandex Cloud (p-ulovkin)"
  type        = string
}
variable "YC_FOLDER_ID" {
  description = "Идентификатор каталога Yandex Cloud (sys34-diploma)"
  type        = string
}
variable "YC_ZONES" {
  default = ["ru-central1-a", "ru-central1-b"]
}

variable "platform_id" { default = "standard-v3" }
variable "image_id" { default = "fd8lp26plun0ke6jooml"}
variable "disk_size" { default = 10 }

variable "instance_resources" {
  default = {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }
}

variable "scheduling_policy" {
  default = {
    preemptible   = false
  }
}