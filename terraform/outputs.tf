output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.private_subnets
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

