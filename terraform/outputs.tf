output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.private_subnets
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

