# Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = var.region
}

/*
# Create a new Virtual Cloud Network
resource "oci_core_virtual_network" "my_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_id
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
}

# Create a new subnet within the VCN
resource "oci_core_subnet" "my_subnet" {
  cidr_block        = var.subnet_cidr_block
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_virtual_network.my_vcn.id
  display_name      = var.subnet_display_name
  dns_label         = var.subnet_dns_label
  route_table_id    = oci_core_route_table.my_route_table.id
  security_list_ids = [oci_core_security_list.my_security_list.id]
  prohibit_internet_ingress = var.subnet_public_access
	prohibit_public_ip_on_vnic = var.subnet_public_access
}


# Create a new route table for the VCN
resource "oci_core_route_table" "my_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "my_route_table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.my_internet_gateway.id
  }
}

# Create a new internet gateway for the VCN
resource "oci_core_internet_gateway" "my_internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "my_internet_gateway"
}

# Create a new security list to allow SSH and HTTPS traffic
resource "oci_core_security_list" "my_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "my_security_list"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      max = 443
      min = 443
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

*/

# Create a new compute instance
resource "oci_core_instance" "my_instances" {
  count               = var.instance_count
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  shape               = var.instance_shape

  source_details {
    source_id   = var.instance_image_id
    source_type = "image"
    boot_volume_size_in_gbs = var.instance_boot_volume_size_in_gbs
    boot_volume_vpus_per_gb = var.instance_boot_volume_vpus_per_gb
        
  }
  shape_config {
    ocpus         = var.instance_ocpu
    memory_in_gbs = var.instance_mem_in_gbs
  }
  display_name = "my_instance_${count.index + 1}"
  create_vnic_details {
    subnet_id        = oci_core_subnet.my_subnet.id
    assign_public_ip = var.subnet_public_access
  }
}

# Create a new block storage volume and attach it to the compute instance
resource "oci_core_volume" "my_volumes" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  count               = var.instance_count
  compartment_id      = var.compartment_id
  display_name        = "my_volume_${count.index + 1}"
  size_in_gbs         = var.instance_secvol_in_gbs
  vpus_per_gb         = var.instance_secvol_vpus_per_gb

}

resource "oci_core_volume_attachment" "my_volume_attachments" {
  attachment_type = "paravirtualized"
  count               = var.instance_count
  instance_id = oci_core_instance.my_instances[count.index].id
  volume_id   = oci_core_volume.my_volumes[count.index].id
}
