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
      -----BEGIN OPENSSH PRIVATE KEY-----
      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
      -----END OPENSSH PRIVATE KEY-----
  - path: /home/${username}/.ssh/config
    permissions: "600"
    content: |
      Host *
          User internal
          IdentityFile /home/${username}/.ssh/internal.key
    defer: true
runcmd:
  - "chown ${username}:${username} /home/${username}/.ssh/internal.key /home/${username}/.ssh/config"