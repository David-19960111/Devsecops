provider "aws" {
  region = var.region 
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region 
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  region = var.region
  vpc_id = module.vpc.vpc_id
  subnets_ids = module.vpc.private_subnets 
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "app-python"
  environment     = "dev"
}

module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = "my-app-bucket-2025"
  environment = "dev"
}
