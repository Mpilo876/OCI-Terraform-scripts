resource "oci_core_virtual_network" "vcn"{
    compartment_id=var.compartment_ocid
    cidr_block    =var.vcn_cidr
    dns_label     =var.vcn_dns_label
    display_name  =var.vcn_dns_label
}

resource "oci_core_instance" "isazi_instance" {
  availability_domain=var.AD
  compartment_id     = var.compartment_ocid
  display_name       = "isazi-instance"
  shape              = var.instance_shape
  image              = "ocid1.image.oc1.me-jeddah-1.aaaaaaaan6sqlzh7323de6ax23r3a7yfzrqpoquwfrlddoh6cmdb22bs4jwa # Replace with the OCID of Ubuntu 21.04 image"

  create_vnic_details {
    # Use an existing VCN and subnet or customize this section for your networking needs
    subnet_id = "your-subnet-ocid" # this value will be found after a vcn has been created or use networking.tf
  }

  metadata {
    user_data = <<-EOF
      #!/bin/bash
      # User data script to customize the instance
      # Add any additional provisioning steps here
    EOF
  }

  block_volume {
    block_volume_replicas = 1
    volume_size_in_gbs   = 1024 # 1TB SSD volume
  }
}