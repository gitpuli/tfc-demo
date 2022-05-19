
   
output "vpc_gke_name" {
  value = google_compute_network.vpc-gke.name
}

output "subnet_gke_name" {
  value = google_compute_subnetwork.subnet-gke.name
}