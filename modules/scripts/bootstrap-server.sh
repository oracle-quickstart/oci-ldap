#!/bin/bash
#######################################################################################################################################################
### This bootstrap script runs on glusterfs servers and does the following
### 1- install & start glusterfs server packages on all server nodes
### 2-install openldap
### 3-config ldap server and client
### 4-check ldap
######################################################################################################################################################
exec &> bootstrap-ldapserver-logfile.txt
set -x


echo "nis_server_sercure_net_list is $nis_server_sercure_net_list"
nis_server_sercure_net_array=($nis_server_sercure_net_list)
nis_server_sercure_net_array_size="$${#nis_server_sercure_net_array[@]}"
echo "nis_server_sercure_net_array_size is $nis_server_sercure_net_array_size"

export nis_sudo_group_name="${nis_sudo_group_name}"
echo "nis_sudo_group_name is $nis_sudo_group_name"

yum -y install ypserv-2.31-11.el7.x86_64 rpcbind-0.2.0-47.el7.x86_64 expect-5.45-14.el7_1.x86_64
this_hostname=`hostname -f`
echo $this_hostname
#first_dot_index=`expr index $this_hostname '.'`
#nis_domain_idex=$((first_dot_index + 1))
#nis_domain_name=`expr substr $this_hostname $nis_domain_idex $${#this_hostname}`

#export nis_domain_name="${nis_domain_name}"
echo "nis_domain_name is $nis_domain_name"
echo $nis_domain_name
sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config 
setenforce 0
systemctl disable firewalld.service
systemctl stop firewalld.service
yum -y install openldap compat-openldap openldap-clients openldap-servers openldap-servers-sql openldap-devel migrationtools 
#/usr/bin/expect <<EOD
#spawn yum -y install openldap compat-openldap openldap-clients openldap-servers openldap-servers-sql openldap-devel migrationtools
#expect "\[y\/d\/N\]"
#send "y\r"
#interact
#EOD
slappasswd -s welcome1
