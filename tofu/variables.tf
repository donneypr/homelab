variable "proxmox_insecure" {
  description = "Skip TLS verification (true until real certs are in place)"
  type        = bool
  default     = true
}

variable "image_datastore" {
  description = "Datastore holding the downloaded cloud image. Must have the Import content type enabled."
  type        = string
  default     = "local"
}

variable "vm_datastore" {
  description = "Datastore for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "cloud_image_url" {
  description = "Ubuntu cloud image URL"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

variable "cloud_image_file_name" {
  description = "Filename to store the image under. Must end in .qcow2 for the import content type."
  type        = string
  default     = "noble-server-cloudimg-amd64.qcow2"
}

variable "vm_username" {
  description = "Cloud-init user created on each VM"
  type        = string
  default     = "don"
}

variable "ssh_public_keys" {
  description = "Public keys authorised for vm_username"
  type        = list(string)
}

variable "network_gateway" {
  description = "Default gateway for the VM subnet"
  type        = string
}

variable "network_bridge" {
  description = "Proxmox bridge to attach VMs to"
  type        = string
  default     = "vmbr0"
}

variable "dns_servers" {
  description = "Resolvers handed to cloud-init. Point at Pi-hole."
  type        = list(string)
}

variable "k3s_nodes" {
  description = "One entry per K3s node: which Proxmox host it lands on, its VMID, and its address in CIDR form"
  type = map(object({
    proxmox_node = string
    vm_id        = number
    ipv4_cidr    = string
    cores = optional(number)
    memory_mb = optional(number)
  }))
}

variable "vm_cores" {
  description = "vCPUs per K3s node"
  type        = number
  default     = 4
}

variable "vm_memory_mb" {
  description = "RAM per K3s node in MiB"
  type        = number
  default     = 10240
}

variable "vm_disk_gb" {
  description = "Root disk size per K3s node in GiB"
  type        = number
  default     = 60
}
