# ------------------------------------------------------------------------------
# Setup Bastion Host
# ------------------------------------------------------------------------------
resource "oci_core_instance" "NisBastion" {
  availability_domain = "${data.template_file.ad_names.*.rendered[var.availability_domains_idx]}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "nis-bastion"
  shape               = "${var.bastion_shape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.BastionSubnet.id}"
    assign_public_ip = true
  }

  metadata {
    ssh_authorized_keys = "${file("${var.bastion_ssh_public_key}")}"
  }

  source_details {
    source_id   = "${var.ClientInstanceImageOCID[var.region]}"
    source_type = "image"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# SETUP THE NIS
# ---------------------------------------------------------------------------------------------------------------------
module "setup_nis" {
  source                          = "../../modules/instances"
  client_count                    = "${var.client_count}"
  ads                             = "${data.template_file.ad_names.*.rendered}"
  server_subnet_id                = "${oci_core_subnet.NISServerSubnetAD.id}"
  client_subnet_id                = "${oci_core_subnet.NISClientSubnetAD.id}"
  region                          = "${var.region}"
  compartment_ocid                = "${var.compartment_ocid}"
  ssh_public_key                  = "${var.ssh_public_key}"
  ssh_private_key                 = "${var.ssh_private_key}"
  bastion_host                    = "${oci_core_instance.NisBastion.public_ip}"
  bastion_user                    = "${var.bastion_user}"
  bastion_ssh_private_key         = "${var.bastion_ssh_private_key}"
  ServerInstanceShape             = "${var.ServerInstanceShape}"
  ClientInstanceShape             = "${var.ClientInstanceShape}"
  nis_domain_name                 = "${var.nis_domain_name}"
  nis_sudo_group_name             = "${var.nis_sudo_group_name}"
}
