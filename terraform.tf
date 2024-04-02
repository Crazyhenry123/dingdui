terraform {
  required_version = ">= 1.2.9"
  required_providers {
    oci = {
      source = "hashicorp/oci"
      version = ">= 5.34.0"
    }
  }
}