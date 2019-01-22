output "ldap_server_private_ip" {
  value = "${oci_core_instance.LDAPServerInstance.private_ip}"
}

output "ldap_server_hostname" {
  value = "${oci_core_instance.LDAPServerInstance.display_name}"
}

output "ldap_server_domainname" {
  value = "${oci_core_subnet.LDAPServerSubnetAD.subnet_domain_name}"
}

output "ldap_client_private_ip_list" {
  value = ["${oci_core_instance.LDAPClientInstances.*.private_ip}"]
}

output "ldap_client_host_names" {
  value = ["${oci_core_instance.LDAPClientInstances.*.display_name}"]
}

output "bastion_private_ip" {
  value = "${oci_core_instance.LdapBastion.private_ip}"
}

output "ldap_login_host_public_ip" {
  value = "${oci_core_instance.LdapBastion.public_ip}"
}
