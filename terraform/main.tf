data "proxmox_virtual_environment_nodes" "nodes" {}

output "cluster_nodes" {
  value = {
    names            = data.proxmox_virtual_environment_nodes.nodes.names
    cpu_count        = data.proxmox_virtual_environment_nodes.nodes.cpu_count
    online           = data.proxmox_virtual_environment_nodes.nodes.online
    memory_available = data.proxmox_virtual_environment_nodes.nodes.memory_available
    uptime           = data.proxmox_virtual_environment_nodes.nodes.uptime
  }
}

