variable "vm_name" {
  description = "Ubuntu virtual machine configuration"
  type        = string
  default     = "test-ubuntu"
}

variable "cpu_cores" {
  description = "Number of CPU cores for the virtual machine"
  type        = number
  default     = 4
}

variable "memory_size" {
  description = "Memory size for the virtual machine in MB"
  type        = number
  default     = 10240
}

variable "disk_size" {
  description = "Disk size for the virtual machine in GB"
  type        = number
  default     = 100
}

variable "network_bridge" {
  description = "Network bridge for the virtual machine"
  type        = string
  default     = "vmbr0"
}

variable "ubuntu_cloud_image_url" {
  description = "URL for the Ubuntu cloud image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/resolute/release/ubuntu-26.04-server-cloudimg-amd64.img"
}

variable "disk_datastore" {
  description = "Datastore for the virtual machine disk"
  type        = string
  default     = "local-lvm"
}

variable "cloud_image_datastore" {
  description = "Datastore for the cloud image"
  type        = string
  default     = "local"
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "pve1"
}

variable "username" {
  description = "Username for the virtual machine"
  type        = string
}

variable "password" {
  description = "Password for the virtual machine"
  type        = string
  sensitive   = true
}