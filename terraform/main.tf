terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  region       = var.region

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
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
