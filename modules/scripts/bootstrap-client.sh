#!/bin/bash
#######################################################################################################################################################
### This bootstrap script runs on glusterfs clients and does the following
### 1- Install gluster packages on all nodes
### 2- Mount client to the glusterFS server volume
### 3- Check if mounted successfully by command "df"
######################################################################################################################################################

exec &> bootstrap-ldapclient-logfile.txt
set -x

export server_host_name="${server_host_name}"
echo "server_host_name is $server_host_name"

export ldap_domain_name="${ldap_domain_name}"
echo "ldap_domain_name is $ldap_domain_name"

export server_domain_name="${server_domain_name}"
echo "server_domain_name is $server_domain_name"

export ldap_server_full_hostname=$server_host_name.$server_domain_name
echo "ldap_server_full_hostname is $ldap_server_full_hostname"

export ldap_sudo_group_name="${ldap_sudo_group_name}"
echo "ldap_sudo_group_name is $ldap_sudo_group_name"

sudo yum install openldap openldap-clients  sssd
rpm -qa | grep sss
cat   /etc/sssd/sssd.conf
cat  /etc/pam.d/system-auth-ac

suso /bin/systemctl restart  sshd.service
