variable "project_id" {
  type = string
  default = "pgtm-gwestenberg"
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
