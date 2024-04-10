## Define variables for user inputs

# General Variable Group
variable "region" {}
variable "compartment_id" {}

# Computer Instance Variable Group
variable "instance_shape" {}
variable "instance_image_id" {}
variable "instance_count" {}
variable "instance_ad" {}
variable "instance_ocpu" {}
variable "instance_mem_in_gbs" {}
variable "instance_secvol_in_gbs" {}
variable "instance_secvol_vpus_per_gb" {}
variable "instance_boot_volume_size_in_gbs" {}
variable "instance_boot_volume_vpus_per_gb" {}

# VCN Variable Group
//variable "vcn_dns_label" {}
//variable "vcn_display_name" {}
//variable "vcn_cidr_block" {}
//variable "subnet_dns_label" {}
//variable "subnet_display_name" {}
//variable "subnet_cidr_block" {}
//variable "subnet_public_access" {}

variable "instance_vcn_id" {}
variable "instance_subnet_id" {}


