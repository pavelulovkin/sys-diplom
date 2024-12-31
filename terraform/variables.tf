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
variable "ZONE" {
  description = "Зона доступности Yandex Cloud"
  type        = string
  default     = "ru-central1-a"
}
variable "NETWORK_NAME" {
  description = "Имя сети VPC"
  type        = string
  default     = "main-vpc"
}

variable "SUBNET_NAT" {
  description = "Блок адресов для подсети NAT"
  type        = string
  default     = "10.0.1.0/24"
}

variable "SUBNET_PRIVATE" {
  description = "Блок адресов для приватной подсети"
  type        = string
  default     = "10.0.2.0/24"
}