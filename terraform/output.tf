resource "local_file" "inventory" {
  content = templatefile(
    "templates/inventory.tftpl",
    {
      servers     = yandex_compute_instance.server[*].network_interface.0.nat_ip_address
      private_key = abspath(var.private_key)

      username = var.admin_username
    }
  )
  filename        = "../internal/inventory.yml"
  file_permission = "0644"
}

resource "local_file" "local_ssh" {
  content = templatefile(
    "templates/ssh_config.tftpl",
    {
      private_key = abspath(var.private_key)
      username    = var.admin_username
      servers     = yandex_compute_instance.server[*].network_interface.0.nat_ip_address
    }
  )

  filename = "../internal/ssh_config"

  provisioner "local-exec" {
    command = "echo 'Include ${abspath("../internal/ssh_config")}' | cat - ~/.ssh/config > temp && mv temp ~/.ssh/config"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sed -i '\\#Include ${abspath("../internal/ssh_config")}#d' ~/.ssh/config"
  }
}

resource "local_file" "ssh_key" {
  content         = tls_private_key.ad_master_key.private_key_pem
  filename        = var.private_key
  file_permission = "0600"
}
