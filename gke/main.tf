module "vpc" {
  source              = "./vpc"
  vpc_gke_name        = var.vpc_gke_name
  vpc_gke_subnet_name = var.vpc_gke_subnet_name
}

module "gke" {
  source                      = "./gke"
  vpc_name                    = module.vpc.vpc_gke_name
  project_id                  = var.project_id
  gke_cluster_name            = var.gke_cluster_name
  subnet_name                 = module.vpc.subnet_gke_name
  ip_secondary_pods_range     = "${module.vpc.subnet_gke_name}-pods-range"
  ip_secondary_services_range = "${module.vpc.subnet_gke_name}-services-range"
  nodes                       = var.nodes
}


data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.kubernetes_cluster_host}"
  token                  = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = base64decode(module.gke.kubernetes_cluster.master_auth[0].cluster_ca_certificate)
}

module "application" {
  source                      = "./application"
}