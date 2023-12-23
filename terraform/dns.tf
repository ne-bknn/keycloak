resource "cloudflare_record" "server_record" {
    count = length(yandex_compute_instance.server)
    zone_id = var.cloudflare_zone_id
    name = yandex_compute_instance.server[count.index].name
    value = yandex_compute_instance.server[count.index].network_interface.0.nat_ip_address
    type = "A"
    proxied = false
}

resource "cloudflare_record" "keycloak_record" {
    count = length(yandex_compute_instance.server)
    zone_id = var.cloudflare_zone_id
    name = "keycloak" 
    value = yandex_compute_instance.server[count.index].network_interface.0.nat_ip_address
    type = "A"
    proxied = false
}