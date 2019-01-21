output "server_ids" {
  value = "${module.nis-server.id}"
}

output "server_private_ips" {
  value = "${module.nis-server.private_ip}"
}

output "server_host_names" {
  value = "${module.nis-server.host_name}"
}

output "client_ids" {
  value = "${module.nis-client.ids}"
}

output "client_private_ips" {
  value = "${module.nis-client.private_ips}"
}

output "client_host_names" {
  value = "${module.nis-client.host_names}"
}
