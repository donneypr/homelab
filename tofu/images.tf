# "local" is node-local storage, so the image has to exist on every node
# that will host a VM. One download per distinct Proxmox host.

locals {
  proxmox_nodes = toset([for n in var.k3s_nodes : n.proxmox_node])
}

resource "proxmox_download_file" "ubuntu_noble" {
  for_each = local.proxmox_nodes

  node_name    = each.value
  datastore_id = var.image_datastore
  content_type = "import"

  url       = var.cloud_image_url
  file_name = var.cloud_image_file_name

  overwrite           = false
  overwrite_unmanaged = true
  upload_timeout      = 1800
}
