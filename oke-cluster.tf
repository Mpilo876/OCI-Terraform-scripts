resource "oci_core_virtual_network" "vcn"{
  cidr_block = "10.0.0.0/16"
  display_name = "my-vcn"
  compartment_id = "your-compartment-id"
}

resource "oci_core_subnet" "private_subnet"{
  cidr_block = "10.0.0.0/24"
  display_name = "private-subnet"
  vcn_id = oci_core_virtual_network.vcn.id
  availability_domain = 1
  route_table_id = oci_core_route_table.rt.id
  security_list_ids = [oci_core_security_list.sl.id]
}

resource "oci_core_route_table" "rt"{
  vcn_id = oci_core_virtual_network.vcn.id
  display_name = "my-route-table"
}

resource "oci_core_security_list" "sl"{
  vcn_id = oci_core_virtual_network.vcn.id
  display_name = "my-security-list"
}

resource "oci_containerengine_cluster" "oke_cluster"{
  compartment_id          = "your-compartment-id"
  kubernetes_version      = "v1.21.4"
  name                   = "my-oke-cluster"
  vcns                   = [oci_core_virtual_network.vcn.id]
  options {
    add_ons {
      is_kubernetes_dashboard_enabled = true
    }
  }
}

output "kubeconfig"{
  value = oci_containerengine_cluster.oke_cluster.kubeconfig
}