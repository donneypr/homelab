# homelab

Declarative infrastructure for a three-node K3s cluster running on Proxmox.
Everything from the hypervisor VM definitions to the workloads running in the
cluster is defined here. A full rebuild is two commands.

## Layers

| Directory | Tool | What it does |
|---|---|---|
| `tofu/` | OpenTofu (bpg/proxmox) | Provisions three Ubuntu VMs on the Proxmox cluster |
| `ansible/` | Ansible | Baselines the VMs, installs K3s in HA mode, bootstraps Argo CD |
| `clusters/prod/` | Argo CD | Everything running inside the cluster |

## Cluster

Three servers with embedded etcd, so all three are control-plane members and
quorum is two. Traefik and servicelb are disabled in favour of MetalLB and a
self-managed ingress controller.

| Host | Address | Role |
|---|---|---|
| k3s-1 | 192.168.2.201 | server, etcd |
| k3s-2 | 192.168.2.202 | server, etcd |
| k3s-3 | 192.168.2.203 | server, etcd |

The LAN reserves 192.168.2.240-254 for static use. MetalLB allocates from
192.168.2.242-250.

## Rebuild

```sh
cd tofu
cp terraform.tfvars.example terraform.tfvars   # then fill it in
export PROXMOX_VE_ENDPOINT="https://<proxmox>:8006/"
export PROXMOX_VE_API_TOKEN="terraform@pve!provider=<secret>"
tofu init && tofu apply

cd ../ansible
ansible-galaxy collection install -r requirements.yml
ansible-playbook site.yml --ask-vault-pass
```

The playbook writes a kubeconfig to the repo root. It is gitignored.

## GitOps

`clusters/prod/bootstrap/root-app.yaml` is an app-of-apps root applied once by
the playbook. It watches `clusters/prod/apps/`, so anything added there is
picked up automatically.

- `clusters/prod/apps/` holds Argo CD `Application` resources, one file per app
- `clusters/prod/manifests/` holds raw manifests that those Applications point at

Adding a workload means committing a file. Removing one means deleting it.
`selfHeal` and `prune` are on, so manual `kubectl` changes are reverted.

## Secrets

The K3s cluster token lives in `ansible/group_vars/k3s_cluster/vault.yml`,
encrypted with ansible-vault. The vault password is not in this repo.

## Not yet done

- Sealed Secrets, so cluster secrets can live in git
- NFS or Longhorn storage (local-path pins pods to nodes)
- cert-manager and an ingress controller
- Kured, for serialised node reboots without losing etcd quorum
