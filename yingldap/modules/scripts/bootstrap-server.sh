#!/bin/bash
#######################################################################################################################################################
### This bootstrap script runs on glusterfs servers and does the following
### 1- install & start glusterfs server packages on all server nodes
### 2- Prepare bricks for creating glusterfs volume
### 3- Only open the needed ports in firewall
### 4- Add each sever into glusterfs peers
######################################################################################################################################################

exec &> bootstrap-server-logfile.txt
set -x


export nis_server_sercure_net_list="${nis_server_sercure_net_list}"
echo "nis_server_sercure_net_list is $nis_server_sercure_net_list"
nis_server_sercure_net_array=($nis_server_sercure_net_list)
nis_server_sercure_net_array_size="$${#nis_server_sercure_net_array[@]}"
echo "nis_server_sercure_net_array_size is $nis_server_sercure_net_array_size"



