# Terraform AWS EKS module

Creates an Amazon EKS cluster and one managed node group. It also creates the
IAM roles and AWS managed policy attachments required by the cluster and nodes.
The VPC is supplied by the caller; this module does not create VPC resources.

## Example using the VPC module

```hcl
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../terraform-vpc-module"
  name   = "demo"
}

module "eks" {
  source = "../terraform-eks-module"

  name = "demo-eks"

  # EKS networking includes both subnet tiers; worker nodes stay private.
  cluster_subnet_ids = concat(
    module.vpc.public_subnet_ids,
    module.vpc.private_subnet_ids,
  )
  node_subnet_ids = module.vpc.private_subnet_ids

  desired_size  = 2
  min_size      = 1
  max_size      = 3
  instance_types = ["t3.medium"]

  tags = {
    Environment = "demo"
  }
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
```

Choose at least two cluster subnets in different availability zones. The
cluster network can include public and private subnet IDs, while
`node_subnet_ids` controls where worker nodes run. The default node group uses
On-Demand `t3.medium` instances. The Kubernetes API endpoint is
reachable both publicly and privately by default; set `endpoint_public_access`
to `false` to restrict it to the VPC network. AWS charges for the EKS cluster
and running EC2 worker nodes.
