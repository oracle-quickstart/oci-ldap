output "id" {
  value = "${oci_core_instance.LDAPServerInstance.id}"
}

output "private_ip" {
  value = "${oci_core_instance.LDAPServerInstance.private_ip}"
}

output "host_name" {
  value = "${oci_core_instance.LDAPServerInstance.display_name}"
}

output "domain_name" {
  value = "${data.oci_core_subnet.server_subnet.subnet_domain_name}"
}
