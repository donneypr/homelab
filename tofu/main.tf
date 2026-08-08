terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.66"
    }
  }
}

provider "proxmox" {
  # endpoint and api_token come from PROXMOX_VE_* env vars
  insecure = true

  ssh {
    agent    = true
    username = "root"
  }
}
