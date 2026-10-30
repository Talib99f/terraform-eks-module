
locals {
  tags               = merge(var.tags, { ManagedBy = "Terraform" })
  cluster_subnet_ids = length(var.cluster_subnet_ids) > 0 ? var.cluster_subnet_ids : var.subnet_ids
  node_subnet_ids    = length(var.node_subnet_ids) > 0 ? var.node_subnet_ids : var.subnet_ids
}
