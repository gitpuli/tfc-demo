resource "google_compute_subnetwork" "subnet-gke" {
  name = var.vpc_gke_subnet_name
  ip_cidr_range = "10.2.0.0/16"
  region = var.region
  network = google_compute_network.vpc-gke.name

  secondary_ip_range = [
    {
      range_name    = "${var.vpc_gke_subnet_name}-services-range"
      ip_cidr_range = "192.168.1.0/24"
    },
    {
      range_name    = "${var.vpc_gke_subnet_name}-pods-range"
      ip_cidr_range = "192.168.64.0/22"
    }
  ]
}

resource "google_compute_network" "vpc-gke" {
  name                    = var.vpc_gke_name
  auto_create_subnetworks = false
}