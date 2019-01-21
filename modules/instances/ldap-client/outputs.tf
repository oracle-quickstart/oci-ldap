output "ids" {
  value = ["${oci_core_instance.ldapClientInstances.*.id}"]
}

output "private_ips" {
  value = ["${oci_core_instance.ldapClientInstances.*.private_ip}"]
}

output "host_names" {
  value = ["${oci_core_instance.ldapClientInstances.*.display_name}"]
}
