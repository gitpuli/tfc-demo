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
}

variable "vpc_gke_name" {
  type    = string
}

variable "vpc_gke_subnet_name" {
  type    = string
}

variable "nodes" {
  type    = string
}