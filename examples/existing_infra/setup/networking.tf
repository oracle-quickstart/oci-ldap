resource "oci_core_virtual_network" "LDAPVCN" {
  cidr_block     = "${var.network_cidrs}"
  compartment_id = "${var.compartment_ocid}"
  dns_label      = "${var.dnsLabel}"
  display_name   = "LDAPVCN"
}

resource "oci_core_internet_gateway" "LDAPInternetG" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "LDAPInternetG"
  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"
}

resource "oci_core_nat_gateway" "LDAPNatG" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"
  display_name   = "LDAPNatG"
}

resource "oci_core_route_table" "PublicRouteTable" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"
  display_name   = "PublicRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.LDAPInternetG.id}"
  }
}

resource "oci_core_route_table" "PrivateRouteTable" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"
  display_name   = "PrivateRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_nat_gateway.LDAPNatG.id}"
  }
}

############################################
# Create Security List
############################################
resource "oci_core_security_list" "PrivateSeclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "PrivateSeclist"
  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"

  egress_security_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      tcp_options {
        "max" = 944
        "min" = 944
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      tcp_options {
        "max" = 111
        "min" = 111
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      udp_options {
        "max" = 944
        "min" = 944
      }

      protocol = "17"
      source   = "0.0.0.0/0"
    },
    {
      udp_options {
        "max" = 111
        "min" = 111
      }

      protocol = 17
      source   = "0.0.0.0/0"
    },
    {
      tcp_options {
        "max" = 945
        "min" = 945
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      udp_options {
        "max" = 945
        "min" = 945
      }

      protocol = "17"
      source   = "0.0.0.0/0"
    },
    {
      udp_options {
        "max" = 946
        "min" = 946
      }

      protocol = "17"
      source   = "0.0.0.0/0"
    },
  ]
}

resource "oci_core_security_list" "BastionSeclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "BastionSeclist"
  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"

  egress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol    = "6"
      destination = "${var.network_cidrs}"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "0.0.0.0/0"
    },
  ]
}

############################################
# Create LDAP Server Subnet
############################################
resource "oci_core_subnet" "LDAPServerSubnetAD" {
  availability_domain = "${data.template_file.ad_names.*.rendered[var.availability_domains_idx]}"
  cidr_block          = "${cidrsubnet(oci_core_virtual_network.LDAPVCN.cidr_block, 8 , count.index + 1)}"
  display_name        = "serverSubnetAD"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.LDAPVCN.id}"
  route_table_id      = "${oci_core_route_table.PrivateRouteTable.id}"

  security_list_ids = [
    "${oci_core_security_list.PrivateSeclist.id}",
  ]

  dns_label = "${var.dnsLabel}ser"
}

resource "oci_core_subnet" "LDAPClientSubnetAD" {
  availability_domain = "${data.template_file.ad_names.*.rendered[var.availability_domains_idx]}"
  cidr_block          = "${cidrsubnet(oci_core_virtual_network.LDAPVCN.cidr_block, 12 , count.index + 1)}"
  display_name        = "clientSubnetAD"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.LDAPVCN.id}"
  route_table_id      = "${oci_core_route_table.PrivateRouteTable.id}"

  security_list_ids = [
    "${oci_core_virtual_network.LDAPVCN.default_security_list_id}",
  ]

  dns_label = "${var.dnsLabel}cli"
}

resource "oci_core_subnet" "BastionSubnet" {
  availability_domain = "${data.template_file.ad_names.*.rendered[var.availability_domains_idx]}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "BastionSubnetAD"
  cidr_block          = "${cidrsubnet(oci_core_virtual_network.LDAPVCN.cidr_block, 14 , 0)}"

  security_list_ids = [
    "${oci_core_security_list.BastionSeclist.id}",
  ]

  vcn_id         = "${oci_core_virtual_network.LDAPVCN.id}"
  route_table_id = "${oci_core_route_table.PublicRouteTable.id}"
}
