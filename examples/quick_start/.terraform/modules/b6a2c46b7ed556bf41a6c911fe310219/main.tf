data "template_file" "install_nis_server" {
  template = "${file("${path.module}/../../scripts/bootstrap-server.sh")}"

  vars {
    nis_domain_name             = "${var.nis_domain_name}"
    nis_sudo_group_name         = "${var.nis_sudo_group_name}"
    nis_server_sercure_net_list = "${join(" ", var.nis_server_sercure_net_list)}"
  }
}

resource "oci_core_instance" "NISServerInstance" {
  availability_domain = "${var.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.nis_server_hostname_prefix}"
  shape               = "${var.shape}"

  create_vnic_details {
    subnet_id        = "${var.subnet_id}"
    display_name     = "${var.nis_server_hostname_prefix}"
    hostname_label   = "${var.nis_server_hostname_prefix}"
    assign_public_ip = "${var.assign_public_ip_to_vm}"
  }

  metadata {
    ssh_authorized_keys = "${file("${var.ssh_public_key}")}"
  }

  source_details {
    source_id   = "${var.image_id}"
    source_type = "image"
  }

  connection = {
    host        = "${self.private_ip}"
    agent       = false
    timeout     = "10m"
    user        = "${var.ssh_user}"
    private_key = "${file("${var.ssh_private_key}")}"

    bastion_host        = "${var.bastion_host}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${file("${var.bastion_ssh_private_key}")}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_nis_server.rendered}"
    destination = "~/bootstrap-server.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/bootstrap-server.sh",
      "sudo sh ~/bootstrap-server.sh",
    ]
  }

  timeouts {
    create = "15m"
  }
}

data "oci_core_subnet" "server_subnet" {
  subnet_id = "${var.subnet_id}"
}
