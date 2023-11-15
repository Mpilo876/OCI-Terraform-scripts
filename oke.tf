provider "oci" {
  # Configure your Oracle Cloud provider settings here
}

module "oci_k8s_cluster" {
  source = "./modules/kubernetes_cluster"

  compartment_id   = var.compartment_id
  cluster_name     = var.cluster_name
  k8s_version      = var.k8s_version
  node_pool_name   = var.node_pool_name
  node_pool_shape  = var.node_pool_shape
  node_pool_count  = var.node_pool_count
  ssh_public_key   = var.ssh_public_key
}

output "k8s_cluster_info" {
  value = module.oci_k8s_cluster.cluster_info
}


#output 
output "k8s_cluster_info" {
  value = module.oci_k8s_cluster.cluster_info
}

# create kubernetes cluster 
resource "oci_containerengine_cluster" "k8s_cluster" {
  compartment_id = var.compartment_id
  name          = var.cluster_name
  kubernetes_version = var.k8s_version

  # Add more cluster configuration as needed
}

resource "oci_containerengine_node_pool" "node_pool" {
  compartment_id = var.compartment_id
  name           = var.node_pool_name
  cluster_id     = oci_containerengine_cluster.k8s_cluster.id
  node_shape     = var.node_pool_shape
  quantity_per_subnet = var.node_pool_count

  # Add more node pool configuration as needed
}

