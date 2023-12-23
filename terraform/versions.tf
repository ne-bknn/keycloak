terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.104.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
