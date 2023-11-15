# data from tfvars file 
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}

# choosing availability domain
variable "AD" {
  default = 1
}

# choosing VCN CIDR
variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

# choosing VCN name
variable "vcn_dns_label" {
  description = "VCN DNS label"
  default = "vcn01"
}

#DNS
variable "dns_label" {
  description = "subnet DNS label"
  default = "subnet"
}

#OS image
variable "image_operating_system" {
  default = "Ubuntu"
}
# will change to ubuntu(v. 22.04.1) later ... for practical purposes only 
variable "image_operating_system_version" {
  default = "22.04"
}

#compute shape
variable "instance_shape" {
  description = "Instance Shape"
  default = "VM.Standard.E2.1.Micro"
}

#Load balancer Shape
variable "load_balancer_min_band" {
  description = "Load Balancer Min Band"
  default = "10"
}

variable "load_balancer_max_band" {
  description = "Load Balancer Max Band"
  default = "10"
}

