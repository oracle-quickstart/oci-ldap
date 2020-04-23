module "setup_ldap" {
  source                           = "../../modules/instance-configure"
  ldap_login_host_public_ip        = "${var.ldap_login_host_public_ip}"
  ldap_login_user                  = "${var.ldap_login_user}"
  ldap_login_host_ssh_private_key  = "${var.ldap_login_host_ssh_private_key}"
  ldap_server_hostname             = "${var.ldap_server_hostname}"
  ldap_server_domainname           = "${var.ldap_server_domainname}"
  ldap_domain_name                 = "${var.ldap_domain_name}"
  ldap_server_private_ip           = "${var.ldap_server_private_ip}"
  ldap_server_user                 = "${var.ldap_server_user}"
  ldap_server_ssh_private_key      = "${var.ldap_server_ssh_private_key}"
  ldap_server_sercure_net_list     = "${var.ldap_server_sercure_net_list}"
  ldap_client_private_ip_list      = "${var.ldap_client_private_ip_list}"
  ldap_client_private_user_list    = "${var.ldap_client_private_user_list}"
  ldap_client_ssh_private_key_list = "${var.ldap_client_ssh_private_key_list}"
  ldap_sudo_group_name             = "${var.ldap_sudo_group_name}"
}
