variable "vm_name" {
  description = "Ubuntu virtual machine configuration"
  type        = string
}

variable "cpu_cores" {
  description = "Number of CPU cores for the virtual machine"
  type        = number
}

variable "memory_size" {
  description = "Memory size for the virtual machine in MB"
  type        = number
}

variable "disk_size" {
  description = "Disk size for the virtual machine in GB"
  type        = number
}

variable "network_bridge" {
  description = "Network bridge for the virtual machine"
  type        = string
}

variable "ubuntu_cloud_image_url" {
  description = "URL for the Ubuntu cloud image"
  type        = string
}

variable "disk_datastore" {
  description = "Datastore for the virtual machine disk"
  type        = string
}

variable "cloud_image_datastore" {
  description = "Datastore for the cloud image"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
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