variable "project_id" {
  type = string
  default = "sylvan-mode-180804"
}

variable "zone" {
  type = string
  default = "us-central1-c"
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "credentials_path" {
  type    = string
  default = "creds.json"
}

variable "gke_cluster_name" {
  type    = string
  default = "gke-cluster"
}

variable "vpc_gke_name" {
  type    = string
  default = "vpc-gke"
}

variable "vpc_gke_subnet_name" {
  type    = string
  default = "subnet-gke-00"
}

variable "nodes" {
  type    = string
  default = 3
}