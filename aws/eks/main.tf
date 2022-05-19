data "aws_availability_zones" "available" {}

provider "aws" {
  region = var.aws_region
}
module "network" {
  source          = "./modules/network"
  name            = var.name
  cidr            = var.vpc_cidr
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  azs             = data.aws_availability_zones.available.names
}

module "eks" {
  source                         = "./modules/eks"
  name                           = var.name
  master_version                 = "1.22"
  cluster_endpoint_public_access = var.eks_cluster_endpoint_public_access
  subnet_ids                     = module.network.private_subnet_ids
  instance_types                 = var.eks_instance_types
  min_size                       = var.eks_min_size
  max_size                       = var.eks_max_size
  desired_size                   = var.eks_desired_size
  depends_on                     = [module.network]
}


resource "local_file" "kubeconfig" {
  content  = <<KUBECONFIG_END
  apiVersion: v1
  clusters:
  - cluster:
      certificate-authority-data: ${module.eks.eks_cluster.certificate_authority.0.data}
      server: ${module.eks.eks_cluster.endpoint}
      name: ${module.eks.eks_cluster.arn}
  contexts:
  - context:
      cluster: ${module.eks.eks_cluster.arn}
      user : ${module.eks.eks_cluster.arn}
    name: ${module.eks.eks_cluster.arn}
  current-context: ${module.eks.eks_cluster.arn}
  kind: Config
  preferences: {}
  users:
  - name: ${module.eks.eks_cluster.arn}
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1alpha1
        command: aws-iam-authenticator
        args:
          - "token"
          - "-i"
          - "${module.eks.eks_cluster.name}"
  KUBECONFIG_END
  filename = "kubeconfig"
}



data "aws_eks_cluster" "msur" {
  name = module.eks.cluster_id
}
# Use kubernetes provider to work with the kubernetes cluster API
provider "kubernetes" {
  
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.msur.certificate_authority.0.data)
  host                   = data.aws_eks_cluster.msur.endpoint
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", "${data.aws_eks_cluster.msur.name}"]
  }
}

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.msur.endpoint
#   token                  = data.aws_eks_cluster.msur.token
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.msur.0.data)
# }

# Create a namespace for microservice pods 
resource "kubernetes_namespace" "ms-namespace" {
  metadata {
    name = "test"
  }
}
