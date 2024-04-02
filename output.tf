
# Output the public IP address of the compute instance
output "instance_public_ip" {
  value = oci_core_instance.my_instances[*].public_ip
}