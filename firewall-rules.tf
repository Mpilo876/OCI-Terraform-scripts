resource "oci_core_network_security_group" "bastion_sg" {
  compartment_id = "your_compartment_id"
  vcn_id        = "your_vcn_id"
  display_name  = "bastion-sg"
}

resource "oci_core_network_security_group_security_rule" "bastion_ssh" {
  network_security_group_id = oci_core_network_security_group.bastion_sg.id
  description              = "Allow SSH from bastion to PostgreSQL"
  direction                = "INGRESS"
  protocol                 = "6"  # TCP
  source_type              = "CIDR_BLOCK"
  source                   = "bastion_public_ip/32"  # Replace with bastion's public IP
  destination_type         = "NETWORK_SECURITY_GROUP"
  destination              = oci_core_network_security_group.bastion_sg.id
  tcp_options {
    source_port_range      = "22"
    destination_port_range = "22"
  }
}

resource "oci_core_network_security_group_security_rule" "postgres" {
  network_security_group_id = oci_core_network_security_group.bastion_sg.id
  description              = "Allow PostgreSQL from Kubernetes Worker Nodes"
  direction                = "INGRESS"
  protocol                 = "6"  # TCP
  source_type              = "NETWORK_SECURITY_GROUP"
  source                   = oci_core_network_security_group.k8s_worker_sg.id
  destination_type         = "NETWORK_SECURITY_GROUP"
  destination              = oci_core_network_security_group.bastion_sg.id
  tcp_options {
    source_port_range      = "5432"
    destination_port_range = "5432"
  }
}

resource "oci_core_network_security_group" "k8s_worker_sg" {
  compartment_id = "your_compartment_id"
  vcn_id        = "your_vcn_id"
  display_name  = "k8s-worker-sg"
}

resource "oci_core_network_security_group_security_rule" "k8s_web" {
  network_security_group_id = oci_core_network_security_group.k8s_worker_sg.id
  description              = "Allow web (443) Inbound"
  direction                = "INGRESS"
  protocol                 = "6"  # TCP
  source_type              = "CIDR_BLOCK"
  source                   = "0.0.0.0/0"  # Replace with appropriate source IP range
  destination_type         = "NETWORK_SECURITY_GROUP"
  destination              = oci_core_network_security_group.k8s_worker_sg.id
  tcp_options {
    source_port_range      = "443"
    destination_port_range = "443"
  }
}

resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = "your_compartment_id"
  vcn_id        = "your_vcn_id"
  display_name  = "nat-gateway"
  block_traffic {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"  # Specify your desired CIDR block for internet access
  }
}

resource "oci_core_private_ip" "nat_private_ip" {
  compartment_id = "your_compartment_id"
  display_name  = "nat-private-ip"
  vnic_id       = oci_core_nat_gateway.nat_gateway.vnic_id
}

resource "oci_core_network_security_group_security_rule" "nat_rule" {
  network_security_group_id = oci_core_network_security_group.k8s_worker_sg.id
  description              = "Allow egress traffic via NAT gateway"
  direction                = "EGRESS"
  protocol                 = "6"  # TCP
  source_type              = "CIDR_BLOCK"
  source                   = "0.0.0.0/0"  # Replace with appropriate source IP range
  destination_type         = "CIDR_BLOCK"
  destination              = oci_core_nat_gateway.nat_gateway.ip_address
  tcp_options {
    source_port_range      = "1024-65535"
    destination_port_range = "0-65535"
  }
}