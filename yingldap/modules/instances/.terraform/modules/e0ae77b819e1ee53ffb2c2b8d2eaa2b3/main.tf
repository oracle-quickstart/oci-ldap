data "template_file" "install_ldap_server" {
  template = "${file("${path.module}/../../scripts/bootstrap-server.sh")}"

  vars {

    ldap_domain_name              = "${var.ldap_domain_name}"
  }
}


resource "oci_core_instance" "NISServerInstance" {
  availability_domain = "${var.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.ldap_server_hostname_prefix}"
  shape               = "${var.shape}"

  create_vnic_details {
    subnet_id = "${var.subnet_id}"
    display_name     = "${var.ldap_server_hostname_prefix}"
    hostname_label   = "${var.ldap_server_hostname_prefix}"
    assign_public_ip = false
  }

  metadata {
    ssh_authorized_keys = "${file("${var.ssh_public_key}")}"
  }

  source_details {
    source_id   = "${var.image_id}"
    source_type = "image"
  }

  provisioner "file" {
    connection = {
      host        = "${self.private_ip}"
      agent       = false
      timeout     = "5m"
      user        = "opc"
      private_key = "${file("${var.ssh_private_key}")}"

      bastion_host        = "${var.bastion_host}"
      bastion_user        = "${var.bastion_user}"
      bastion_private_key = "${file("${var.bastion_ssh_private_key}")}"
    }

    content     = "${data.template_file.install_ldap_server.rendered}"
    destination = "~/bootstrap-server.sh"
  }

  provisioner "remote-exec" {
    connection = {
      host        = "${self.private_ip}"
      agent       = false
      timeout     = "10m"
      user        = "opc"
      private_key = "${file("${var.ssh_private_key}")}"

      bastion_host        = "${var.bastion_host}"
      bastion_user        = "${var.bastion_user}"
      bastion_private_key = "${file("${var.bastion_ssh_private_key}")}"
    }

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
