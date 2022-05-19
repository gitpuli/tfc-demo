variable "name" {
  description = "Name of most resources"
  type        = string
  default     = "eks-cluster"
}

variable "aws_region" {
  description = "Region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  validation {
    condition     = length(var.vpc_private_subnets) > 0
    error_message = "Specify at least one private subnet."
  }
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  validation {
    condition     = length(var.vpc_public_subnets) > 0
    error_message = "Specify at least one public subnet."
  }
}

variable "eks_cluster_endpoint_public_access" {
  description = <<EOT
     Indicates whether or not the Amazon EKS public API server endpoint is enabled
     EOT
  type        = bool
  default     = true
}

variable "eks_instance_types" {
  description = "Set of instance types associated with default Node Group."
  type        = list(string)
  default     = ["t3.2xlarge"]
}

variable "eks_max_size" {
  description = "EKS's 'default' node group max_size"
  type        = number
  default     = 2
}

variable "eks_min_size" {
  description = "EKS's 'default' node group min_size"
  type        = number
  default     = 2
}

variable "eks_desired_size" {
  description = "EKS's 'default' node group desired_size"
  type        = number
  default     = 2
}

