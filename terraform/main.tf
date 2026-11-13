resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name            = var.vm_name
  node_name       = var.node_name
  stop_on_destroy = true


  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_account {
      username = var.username
      password = var.password
    }
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_size
  }

  network_device {
    bridge = var.network_bridge
  }

  disk {
    datastore_id = var.disk_datastore
    import_from  = proxmox_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

  serial_device {
    device = "socket"
  }
}

resource "proxmox_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = var.cloud_image_datastore
  node_name    = var.node_name
  url          = var.ubuntu_cloud_image_url
  file_name    = "ubuntu-26.04-server-cloudimg-amd64.qcow2"
}
