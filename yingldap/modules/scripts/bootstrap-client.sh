#!/bin/bash
#######################################################################################################################################################
### This bootstrap script runs on glusterfs clients and does the following
### 1- Install gluster packages on all nodes
### 2- Mount client to the glusterFS server volume
### 3- Check if mounted successfully by command "df"
######################################################################################################################################################

exec &> bootstrap-client-logfile.txt
set -x

export server_host_name="${server_host_name}"
echo "server_host_name is $server_host_name"

export nis_domain_name="${nis_domain_name}"
echo "nis_domain_name is $nis_domain_name"

export server_domain_name="${server_domain_name}"
echo "server_domain_name is $server_domain_name"

export nis_server_full_hostname=$server_host_name.$server_domain_name
echo "nis_server_full_hostname is $nis_server_full_hostname"


