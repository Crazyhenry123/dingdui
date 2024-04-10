
# Fetch the list of availability domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "cloudinit_config" "this" {
  part {
    content = file("user-data-this.yaml")
  }
}

/*
data "oci_core_shape" "vm_standard3_flex_shape" {
  compartment_id = var.compartment_id
  image_id       = var.instance_image_id

  filter {
    name   = "shape"
    values = ["VM.Standard3.Flex"]
  }
}
*/