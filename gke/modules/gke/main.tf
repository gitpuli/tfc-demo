resource "google_container_cluster" "gke-cluster" {
  name = var.gke_cluster_name
  location = var.zone
  project = var.project_id
  network = var.vpc_name
  subnetwork = var.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name = var.ip_secondary_pods_range
    services_secondary_range_name = var.ip_secondary_services_range
  }

  remove_default_node_pool = true
  initial_node_count = var.nodes
}

resource "google_container_node_pool" "gke-cluster-pool" {
  name = "${google_container_cluster.gke-cluster.name}-nodepool"
  project = var.project_id
  cluster = google_container_cluster.gke-cluster.name
  location = var.zone
  node_count = var.nodes

  node_config {
    preemptible = true
    machine_type = "e2-medium"
  }
}