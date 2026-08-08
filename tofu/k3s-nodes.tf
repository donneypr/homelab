resource "proxmox_virtual_environment_vm" "k3s" {
  for_each = var.k3s_nodes

  name        = each.key
  description = "K3s node, managed by OpenTofu. Manual changes will be reverted."
  tags        = ["k3s", "tofu"]

  node_name = each.value.proxmox_node
  vm_id     = each.value.vm_id

  machine       = "q35"
  bios          = "seabios"
  scsi_hardware = "virtio-scsi-single"
  on_boot       = true

  agent {
    enabled = false
  }

  cpu {
    cores = coalesce(each.value.cores, var.vm_cores)
    type  = "host"
  }

  memory {
    dedicated = coalesce(each.value.memory_mb, var.vm_memory_mb)
  }

  disk {
    datastore_id = var.vm_datastore
    import_from  = proxmox_download_file.ubuntu_noble[each.value.proxmox_node].id
    interface    = "scsi0"
    size         = var.vm_disk_gb
    iothread     = true
    discard      = "on"
    ssd          = true
  }

  initialization {
    datastore_id = var.vm_datastore
    interface    = "ide2"

    ip_config {
      ipv4 {
        address = each.value.ipv4_cidr
        gateway = var.network_gateway
      }
    }

    dns {
      servers = var.dns_servers
    }

    user_account {
      username = var.vm_username
      keys     = var.ssh_public_keys
    }
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
