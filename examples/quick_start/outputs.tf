output "server_ids" {
  value = [
    "${module.setup_nis.server_ids}",
  ]
}

output "server_private_ips" {
  value = [
    "${module.setup_nis.server_private_ips}",
  ]
}

output "server_host_names" {
  value = [
    "${module.setup_nis.server_host_names}",
  ]
}

output "client_ids" {
  value = [
    "${module.setup_nis.client_ids}",
  ]
}

output "client_private_ips" {
  value = [
    "${module.setup_nis.client_private_ips}",
  ]
}

output "client_host_names" {
  value = [
    "${module.setup_nis.client_host_names}",
  ]
}

output "bastion_id" {
  value = "${oci_core_instance.NisBastion.id}"
}

output "bastion_private_ip" {
  value = "${oci_core_instance.NisBastion.private_ip}"
}

output "bastion_public_ip" {
  value = "${oci_core_instance.NisBastion.public_ip}"
}
