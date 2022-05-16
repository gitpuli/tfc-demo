variable "vpc_gke_name" {
  type    = string
  default = "vpc-gke"
}

variable "vpc_gke_subnet_name" {
  type    = string
  default = "subnet-gke-00"
}

variable "zone" {
  type     = string
  default = "us-central1-c"
}

variable "region" {
  type    = string
  default = "us-central1"
}