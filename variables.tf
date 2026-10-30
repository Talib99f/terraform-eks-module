variable "name" {
  description = "Name for the EKS cluster and managed node group."
  type        = string
  default     = "app-eks"
}

variable "subnet_ids" {
  description = "Legacy fallback: subnet IDs used for both the EKS cluster and managed node group. Prefer cluster_subnet_ids and node_subnet_ids."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.subnet_ids) == 0 || length(var.subnet_ids) >= 2
    error_message = "When provided, subnet_ids must contain at least two subnet IDs."
  }
}

variable "cluster_subnet_ids" {
  description = "Subnet IDs for EKS cluster networking. Falls back to subnet_ids when empty."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.cluster_subnet_ids) == 0 || length(var.cluster_subnet_ids) >= 2
    error_message = "When provided, cluster_subnet_ids must contain at least two subnet IDs."
  }
}

variable "node_subnet_ids" {
  description = "Subnet IDs where managed worker nodes can run. Falls back to subnet_ids when empty."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.node_subnet_ids) == 0 || length(var.node_subnet_ids) >= 2
    error_message = "When provided, node_subnet_ids must contain at least two subnet IDs."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster. Null uses the AWS EKS default version."
  type        = string
  default     = null
}

variable "instance_types" {
  description = "EC2 instance types for the managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Managed node group capacity type: ON_DEMAND or SPOT."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "desired_size" {
  description = "Desired number of worker nodes."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "disk_size" {
  description = "Worker node root volume size in GiB."
  type        = number
  default     = 20
}

variable "endpoint_public_access" {
  description = "Whether the Kubernetes API endpoint is reachable from the public internet."
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Whether the Kubernetes API endpoint is reachable from inside the VPC."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags applied to supported EKS resources."
  type        = map(string)
  default     = {}
}
