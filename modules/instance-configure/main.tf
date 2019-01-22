data "template_file" "ldap_server_script" {
  template = "${file("${path.module}/../scripts/bootstrap-server.sh")}"

  vars {
    ldap_domain_name             = "${var.ldap_domain_name}"
    ldap_server_sercure_net_list = "${join(" ", var.ldap_server_sercure_net_list)}"
    ldap_sudo_group_name         = "${var.ldap_sudo_group_name}"
  }
}

data "template_file" "ldap_client_script" {
  template = "${file("${path.module}/../scripts/bootstrap-client.sh")}"

  vars {
    server_host_name    = "${var.ldap_server_hostname}"
    server_domain_name  = "${var.ldap_server_domainname}"
    ldap_domain_name     = "${var.ldap_domain_name}"
    ldap_sudo_group_name = "${var.ldap_sudo_group_name}"
  }
}

resource "null_resource" "configure_ldap_server" {
  connection = {
    host        = "${var.ldap_server_private_ip}"
    agent       = false
    timeout     = "5m"
    user        = "${var.ldap_server_user}"
    private_key = "${file("${var.ldap_server_ssh_private_key}")}"

    bastion_host        = "${var.ldap_login_host_public_ip}"
    bastion_user        = "${var.ldap_login_user}"
    bastion_private_key = "${file("${var.ldap_login_host_ssh_private_key}")}"
  }

  provisioner "file" {
    content     = "${data.template_file.ldap_server_script.rendered}"
    destination = "~/configure-server.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/configure-server.sh",
      "sudo sh ~/configure-server.sh",
    ]
  }
}

resource "null_resource" "configure_ldap_client" {
  count = "${length(var.ldap_client_private_ip_list)}"

  connection = {
    host        = "${var.ldap_client_private_ip_list[count.index]}"
    agent       = false
    timeout     = "5m"
    user        = "${var.ldap_client_private_user_list[count.index]}"
    private_key = "${file("${var.ldap_client_ssh_private_key_list[count.index]}")}"

    bastion_host        = "${var.ldap_login_host_public_ip}"
    bastion_user        = "${var.ldap_login_user}"
    bastion_private_key = "${file("${var.ldap_login_host_ssh_private_key}")}"
  }

  provisioner "file" {
    content     = "${data.template_file.ldap_client_script.rendered}"
    destination = "~/bootstrap-client.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x ~/bootstrap-client.sh",
      "sudo ~/bootstrap-client.sh",
    ]
  }

  depends_on = ["null_resource.configure_ldap_server"]
}
