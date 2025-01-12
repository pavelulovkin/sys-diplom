
#  Дипломная работа по профессии «Системный администратор»

## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/) и отвечать минимальным стандартам безопасности: запрещается выкладывать токен от облака в git. Используйте [инструкцию](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials).

---

## Инфраструктура
Для развёртки инфраструктуры используйте Terraform и Ansible.  
Не используйте для ansible inventory ip-адреса! Вместо этого используйте fqdn имена виртуальных машин в зоне ".ru-central1.internal".

### Инфраструктура: комментарии
Для автоматизации развертывания инфраструктуры ипользуются bash, terraform, ansible. Запуск проекта terraform и playbook-ов ansible выполняются из общего bash-скрипта `./setup.sh` для удобства передачи данных, параметров и выполнения сопутствующих задач (формирование inventory файла, изменение записей dns через api).

---

## Сайт
Создайте две ВМ в разных зонах, установите на них сервер nginx, если его там нет. ОС и содержимое ВМ должно быть идентичным, это будут наши веб-сервера.
Используйте набор статичных файлов для сайта. Можно переиспользовать сайт из домашнего задания.
Виртуальные машины не должны обладать внешним Ip-адресом, те находится во внутренней сети. Доступ к ВМ по ssh через бастион-сервер. Доступ к web-порту ВМ через балансировщик yandex cloud.
Настройка балансировщика:

### Сайт: комментарии



---

## Мониторинг
Создайте ВМ, разверните на ней Zabbix. На каждую ВМ установите Zabbix Agent, настройте агенты на отправление метрик в Zabbix. 
Настройте дешборды с отображением метрик, минимальный набор — по принципу USE (Utilization, Saturation, Errors) для CPU, RAM, диски, сеть, http запросов к веб-серверам. Добавьте необходимые tresholds на соответствующие графики.

### Мониторинг: комментарии



---

## Логи
Cоздайте ВМ, разверните на ней Elasticsearch. Установите filebeat в ВМ к веб-серверам, настройте на отправку access.log, error.log nginx в Elasticsearch.

Создайте ВМ, разверните на ней Kibana, сконфигурируйте соединение с Elasticsearch.

### Логи: комментарии



---

## Сеть
Разверните один VPC. Сервера web, Elasticsearch поместите в приватные подсети. Сервера Zabbix, Kibana, application load balancer определите в публичную подсеть.

### Сеть: комментарии
VPC - network_cloud, подсети - subnet_public, subnet_private_elastic, subnet_private_web (2 подсети в зонах доступности: ru-central1-a, ru-central1-b), subnet_private_elastic `./terraform/network.tf`

Отдельные группы безопасности указаны в `./terraform/security.tf`

Доступ к bastion server по ssh от имени пользователя external, с использованием ключа external. C хоста bastion - доступ на внутренние VM от имени пользователя internal с использованием ключа internal.

Выполнение playbook-ов ansible выполняется с использованием промежуточного хоста bastion.

Исходящий доступ в Интернет организован через nat-gateway

---

## Резервное копирование
Создайте snapshot дисков всех ВМ. Ограничьте время жизни snaphot в неделю. Сами snaphot настройте на ежедневное копирование.

### Резервное копирование: комментарии
 Снапшоты создаются ежедневно согласно расписанию snapshot_schedule. Срок хранения: 168 часов `./terraform/backup.tf`

---
