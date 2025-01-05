#cloud-config
users:
  - name: ${username}
    ssh-authorized-keys:
      - ${ssh_key}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash