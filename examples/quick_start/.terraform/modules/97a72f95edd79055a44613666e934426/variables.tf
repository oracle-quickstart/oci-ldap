variable "compartment_ocid" {}

variable "ads" {
  type = "list"
}

variable "region" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}
variable "ssh_user" {
  default = "opc"
}
variable "server_subnet_id" {}

variable "client_subnet_id" {}

variable "ServerInstanceShape" {
  default = "VM.Standard2.1"
}

variable "ClientInstanceShape" {
  default = "VM.Standard2.1"
}

variable "ClientInstanceImageOCID" {
  type = "map"

  default = {
    // See https://docs.us-phoenix-1.oraclecloud.com/images/
    // Oracle-provided image "Oracle-Linux-7.4-2018.02.21-1"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaupbfz5f5hdvejulmalhyb6goieolullgkpumorbvxlwkaowglslq"

    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7d3fsb6272srnftyi4dphdgfjf6gurxqhmv6ileds7ba3m2gltxq"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaa6h6gj6v4n56mqrbgnosskq63blyv2752g36zerymy63cfkojiiq"
  }
}

variable "ServerInstanceImageOCID" {
  type = "map"

  default = {
    // Oracle-provided image "CentOS-7-2018.01.04-0"
    // See https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaajycoi24gyc4tajpwwxjo63yu76cnhtg5a5cfope4tpalnjnhbjqq"

    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt1.aaaaaaaaw2qeuo2g4flwz5uieo7hkt6a5wa7ol2z6y23yeqgixcinxmxg7ja"
  }
}

variable "client_count" {
  description = "Number of glusterfs client instances to launch. "
  default     = 2
}

variable "bastion_user" {
  default = "opc"
}

variable "bastion_host" {
  default = ""
}

variable "bastion_ssh_private_key" {
  default = ""
}

variable "nis_server_hostname_prefix" {
  default = "nis-server"
}

variable "nis_client_hostname_prefix" {
  default = "nis-client"
}

variable "availability_domains_idx" {
  default = 0
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
variable "nis_server_sercure_net_list" {
  type    = "list"
  default = []
}