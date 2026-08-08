terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.111"
    }
  }
}

provider "proxmox" {
  insecure = var.proxmox_insecure

  # Only needed if you later use proxmox_virtual_environment_file
  # (snippets / custom cloud-init user-data), which the API token
  # alone cannot do. Left commented for now.
  #
  # ssh {
  #   agent    = true
  #   username = "root"
  # }
}
