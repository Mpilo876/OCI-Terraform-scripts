resource "oci_core_virtual_network" "vcn"{
    compartment_id=var.compartment_ocid
    cidr_block    =var.vcn_cidr
    dns_label     =var.vcn_dns_label
    display_name  =var.vcn_dns_label
}

# internet gateway

resource "oci_core_internet_gateway" "igw"{
    compartment_id=var.compartment_ocid
    display_name  ="${var.vcn_dns_label}igw"
    vcn_id        = oci_core_virtual_network.vcn.id
}

#public route table
resource "oci_core_route_table" "PublicRT"{
    compartment_id=var.compartment_ocid
    vcn_id        = oci_core_virtual_network.vcn.id
    display_name  ="${var.vcn_dns_label}pubrt"

    route_rules{
        destination = "0.0.0.0/0"
        network_entity_id = oci_core_internet_gateway.igw.id
    }
}

#subnet
resource "oci_core_subnet" "subnet"{
    count = 5
    availability_domain=var.AD
    compartment_id=var.compartment_ocid
    vcn_id =oci_core_virtual_network.vcn.id
    cidr_block = element(["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"], count.index)
    display_name    = "subnet-${count.index + 1}"
    dns_label= var.dns_label
    route_table_id=oci_core_route_table.PublicRT.id
    security_list_ids = [oci_core_security_list.securitylist.id]
}

#security list 
resource "oci_core_security_list" "securitylist"{
    display_name = "SL_public"
    compartment_id=var.compartment_ocid
    vcn_id =oci_core_virtual_network.vcn.id

    egress_security_rules{
        protocol ="all"
        destination ="0.0.0.0/0"
    }
    ingress_security_rules{
        protocol ="6"
        source ="0.0.0.0/0"

        tcp_options{
        min=80
        max=80
        }
    }
    
    ingress_security_rules {
    protocol ="6"
    source ="0.0.0.0/0"

    tcp_options{
        min=22
        max=22
        }
    }
}





 