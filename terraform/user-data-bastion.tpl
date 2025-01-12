#cloud-config
users:
  - name: ${username}
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${ssh_key}
write_files:
  - path: "/home/${username}/.ssh/internal.key"
    permissions: "600"
    content: |
      ${internal_key}
  - path: /home/${username}/.ssh/config
    permissions: "600"
    content: |
      Host *
          User internal
          IdentityFile /home/${username}/.ssh/internal.key
    defer: true
runcmd:
  - "chown ${username}:${username} /home/${username}/.ssh/internal.key /home/${username}/.ssh/config"