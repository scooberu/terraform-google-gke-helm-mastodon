resource "google_container_cluster" "mastodon_cluster" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.cluster_location

  enable_private_nodes     = var.use_private_endpoint
  enable_private_endpoints = var.use_private_endpoint

  initial_node_count       = 1
  remove_default_node_pool = true

  network    = var.network
  subnetwork = var.subnetwork

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  enable_binary_authorization = true
}
