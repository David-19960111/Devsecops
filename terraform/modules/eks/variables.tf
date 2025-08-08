variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "devops-eks-cluster"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "azs" {
  type        = list(string)
  description = "Lista de zonas de disponibilidad a usar para el EKS"
}
