variable "shape" {
  default = "BM.DenseIO1.36"
}

variable "image_id" {}
variable "region" {}

variable "availability_domain" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}
variable "ssh_user" {
  default = "opc"
}
variable "subnet_id" {}

variable "bastion_user" {
  default = "opc"
}

variable "bastion_host" {
  default = ""
}

variable "bastion_ssh_private_key" {
  default = ""
}

variable "ldap_server_hostname_prefix" {
  default = "ldap-server"
}

variable "ldap_domain_name" {
  default = "ldap.oci.com"
}
variable "ldap_sudo_group_name" {
  default = "sudogroup"
}
variable "assign_public_ip_to_vm" {
  default = "false"
}
variable "ldap_server_sercure_net_list" {
  type    = "list"
  default = []
}
