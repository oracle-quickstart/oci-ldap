variable "shape" {
  default = "VM.Standard2.1"
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
variable "client_count" {
  description = "Number of glusterfs client instances to launch. "
  default     = 2
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

variable "server_host_name" {}

variable "server_domain_name" {}

variable "server_id" {}

variable "nis_client_hostname_prefix" {
  default = "nis-client"
}

variable "nis_domain_name" {
  default = "nis.oci.com"
}

variable "nis_sudo_group_name" {
  default = "sudogroup"
}
variable "assign_public_ip_to_vm" {
  default = "false"
}