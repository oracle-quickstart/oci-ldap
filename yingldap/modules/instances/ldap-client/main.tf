data "template_file" "setup_ldap_client" {
  template = "${file("${path.module}/../../scripts/bootstrap-client.sh")}"

  vars {
    server_host_name                = "${var.server_host_name}"
    server_domain_name              = "${var.server_domain_name}"
    ldap_domain_name              = "${var.ldap_domain_name}"
    server_id              = "${var.server_id}"
  }
}

resource "oci_core_instance" "NISClientInstances" {
  count               = "${var.client_count}"
  availability_domain = "${var.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.ldap_client_hostname_prefix}${count.index+1}"
  shape               = "${var.shape}"

  create_vnic_details {

    subnet_id = "${var.subnet_id}"
    display_name     = "${var.ldap_client_hostname_prefix}${count.index+1}"
    hostname_label   = "${var.ldap_client_hostname_prefix}${count.index+1}"
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

    content     = "${data.template_file.setup_ldap_client.rendered}"
    destination = "~/bootstrap-client.sh"
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
      "chmod +x ~/bootstrap-client.sh",
      "sudo ~/bootstrap-client.sh",
    ]
  }

  timeouts {
    create = "15m"
  }
}
