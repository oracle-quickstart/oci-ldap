output "server_ids" {
  value = "${module.ldap-server.id}"
}

output "server_private_ips" {
  value = "${module.ldap-server.private_ip}"
}

output "server_host_names" {
  value = "${module.ldap-server.host_name}"
}

output "client_ids" {
  value = "${module.ldap-client.ids}"
}

output "client_private_ips" {
  value = "${module.ldap-client.private_ips}"
}

output "client_host_names" {
  value = "${module.ldap-client.host_names}"
}
