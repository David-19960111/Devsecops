variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
}

variable "ecr_repo_name" {
  type    = string
  default = "flask-devsecops"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}