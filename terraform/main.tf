terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
        }
    }
}

provider "proxmox" {
    pm_api_url          = var.pm_api_url
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret
    pm_tls_insecure     = true
}

variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}

resource "proxmox_vm_qemu" "vm-instance" {
    name                = "vm-instance"
    target_node         = "pve3"
    clone               = "ubuntu-2204-template"
    full_clone          = true
    cores               = 1
    memory              = 1028

    disk {
        size            = "32G"
        type            = "scsi"
        storage         = "local-lvm"
        discard         = "on"
    }

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
    }

}