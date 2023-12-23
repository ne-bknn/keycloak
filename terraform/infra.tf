resource "yandex_compute_instance" "server" {
  #checkov:skip=CKV_YC_2:This host should have public ip
  count                     = 5
  allow_stopping_for_update = true
  name                      = "server-${count.index}"
  hostname                  = "server-${count.index}"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.default_image
      type     = "network-ssd"
      size     = 25
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-main.id
    nat        = true
    ip_address = "10.133.0.${count.index + 3}"
  }

  metadata = {
    user-data = local.admin_secret
  }
}

