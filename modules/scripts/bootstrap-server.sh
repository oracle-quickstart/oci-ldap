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
echo rootpw `slappasswd -s welcome1` > /home/opc/slappasswd
echo `slappasswd -s welcome1` >/home/opc/ssa
var1=$(cat /home/opc/ssa)
var=$(cat /home/opc/slappasswd)
sed -i "s/rootpw/`echo $var`/g" slapd.conf
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
cp /home/opc/slapd.conf /etc/openldap/slapd.confcat
sed -i "s/olcRootPW\:/olcRootPW\:  `echo $var1`/g" 2.ldif
cp /home/opc/2.ldif /etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif
sed -i "s/cn=Manager,dc=my-domain,dc=com/cn=root,dc=c9lab,dc=oracle,dc=com/g" /etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif
systemctl enable slapd
systemctl start slapd
systemctl status slapd
ldapadd    -Y EXTERNAL -H ldapi:/// -f   /etc/openldap/schema/cosine.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f   /etc/openldap/schema/inetorgperson.ldif  
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/nis.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/core.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/collective.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/corba.ldif

ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f base.ldif
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f users.ldif 
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f groups.ldif
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f sudogroup.ldif 
