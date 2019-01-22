output "ids" {
  value = ["${oci_core_instance.NISClientInstances.*.id}"]
}

output "private_ips" {
  value = ["${oci_core_instance.NISClientInstances.*.private_ip}"]
}

output "host_names" {
  value = ["${oci_core_instance.NISClientInstances.*.display_name}"]
}
