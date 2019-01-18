
variable "ldap_login_host_public_ip" {}
variable "ldap_login_user" {
  default = "opc"
}
variable "ldap_login_host_ssh_private_key" {}
variable "ldap_server_hostname" {}
variable "ldap_server_domainname" {}
variable "ldap_domain_name" {}
variable "ldap_server_private_ip" {}
variable "ldap_server_user" {
  default = "opc"
}
variable "ldap_server_ssh_private_key" {}
variable "ldap_server_sercure_net_list" {
  type = "list"
  default = []
}
variable "ldap_client_private_ip_list" {
  type = "list"
}
variable "ldap_client_private_user_list" {
  type = "list"
}
variable "ldap_client_ssh_private_key_list" {
  type = "list"
}
variable "ldap_sudo_group_name" {}

