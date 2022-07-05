resource "google_container_cluster" "primary" {
  project   = var.project_id
  name      = "gke-tf-${var.deployment_env}"
  location  = var.region
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_ipv4_cidr_block = "10.0.0.0/14"
    services_ipv4_cidr_block = "10.4.0.0/19"
  }
  
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "np" {
  project   = var.project_id
  name      = "cluster-node-pool-01-${var.deployment_env}"
  location  = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.nodes_count

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
  
    workload_metadata_config {
     mode = "GCE_METADATA"
   }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.default_sa

    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}