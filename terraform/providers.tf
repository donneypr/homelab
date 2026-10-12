terraform {
	required_providers {
		proxmox = {
			source = "bpg/proxmox"
			version = "~> 0.111"
			}
	}
}

provider "proxmox" {
	insecure = true

	ssh {
		agent = true
		username = "root"
	}
}
