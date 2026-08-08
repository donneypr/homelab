output "k3s_nodes" {
  description = "Node name to address map, consumed by the Ansible inventory generator"
  value = {
    for name, cfg in var.k3s_nodes :
    name => {
      proxmox_node = cfg.proxmox_node
      vm_id        = cfg.vm_id
      ipv4         = split("/", cfg.ipv4_cidr)[0]
      ssh_user     = var.vm_username
    }
  }
}

output "k3s_agent_ipv4" {
  description = "Addresses reported by the guest agent, useful for confirming the VMs actually booted"
  value = {
    for name, vm in proxmox_virtual_environment_vm.k3s :
    name => vm.ipv4_addresses
  }
}
