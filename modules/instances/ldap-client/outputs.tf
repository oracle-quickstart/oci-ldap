output "ids" {
  value = ["${oci_core_instance.LDAPClientInstances.*.id}"]
}

output "private_ips" {
  value = ["${oci_core_instance.LDAPClientInstances.*.private_ip}"]
}

output "host_names" {
  value = ["${oci_core_instance.LDAPClientInstances.*.display_name}"]
}
