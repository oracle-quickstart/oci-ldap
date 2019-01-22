#!/bin/bash
#######################################################################################################################################################
### This bootstrap script runs on glusterfs servers and does the following
### 1- install & start glusterfs server packages on all server nodes
### 2- Prepare bricks for creating glusterfs volume
### 3- Only open the needed ports in firewall
### 4- Add each sever into glusterfs peers
######################################################################################################################################################

exec &> bootstrap-ldapserver-logfile.txt
set -x


export ldap_server_sercure_net_list="${ldap_server_sercure_net_list}"
echo "ldap_server_sercure_net_list is $ldap_server_sercure_net_list"
ldap_server_sercure_net_array=($ldap_server_sercure_net_list)
ldap_server_sercure_net_array_size="$${#ldap_server_sercure_net_array[@]}"
echo "ldap_server_sercure_net_array_size is $ldap_server_sercure_net_array_size"

export ldap_sudo_group_name="${ldap_sudo_group_name}"
echo "ldap_sudo_group_name is $ldap_sudo_group_name"

this_hostname=`hostname -f`
echo $this_hostname
#first_dot_index=`expr index $this_hostname '.'`
#ldap_domain_idex=$((first_dot_index + 1))
#ldap_domain_name=`expr substr $this_hostname $ldap_domain_idex $${#this_hostname}`

#export ldap_domain_name="${ldap_domain_name}"
echo "ldap_domain_name is $ldap_domain_name"
echo $ldap_domain_name
