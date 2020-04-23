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

echo "ldap_server_sercure_net_list is $ldap_server_sercure_net_list"
ldap_server_sercure_net_array=($ldap_server_sercure_net_list)
ldap_server_sercure_net_array_size="${#ldap_server_sercure_net_array[@]}"
echo "ldap_server_sercure_net_array_size is $ldap_server_sercure_net_array_size"

export ldap_sudo_group_name="sudogroup"
echo "ldap_sudo_group_name is $ldap_sudo_group_name"
src=/home/opc/git/2019129-ldap/modules/scripts/ldiffile
dsc=/home/opc/
expect -c "
spawn scp -r opc@129.146.112.152:$src $dsc
expect {
\"yes/no\" {send \"yes\r\"; exp_continue;}
}
expect eof"

sudo yum -y install ypserv-2.31-11.el7.x86_64 rpcbind-0.2.0-47.el7.x86_64 expect-5.45-14.el7_1.x86_64
this_hostname=`hostname -f`
echo $this_hostname

export ldap_domain_name="ldapser.ldap.oraclevcn.com"
echo "ldap_domain_name is $ldap_domain_name"
echo $ldap_domain_name

sudo su <<!
sudo sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config
sudo setenforce 0
systemctl disable firewalld.service
systemctl stop firewalld.service
yum -y install openldap compat-openldap openldap-clients openldap-servers openldap-servers-sql openldap-devel migrationtools

echo rootpw `sudo slappasswd -s welcome1` > /home/opc/slappasswd
echo `sudo slappasswd -s welcome1` >/home/opc/ssa
var1=$(cat /home/opc/ssa)
var=$(cat /home/opc/slappasswd)
sed -i "s/rootpw/`echo $var`/g" slapd.conf
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
cp /home/opc/slapd.conf /etc/openldap/slapd.conf
sed -i "s/olcRootPW\:/olcRootPW\:  `echo $var1`/g" 2.ldif
cp /home/opc/2.ldif /etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif
sed -i "s/cn=Manager,dc=my-domain,dc=com/cn=root,dc=c9lab,dc=oracle,dc=com/g" /etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif
systemctl enable slapd
systemctl start slapd
systemctl status slapd
ldapadd    -Y EXTERNAL -H ldapi:/// -f   /etc/openldap/schema/cosine.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f   /etc/openldap/schema/inetorgperson.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/ldap.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/core.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/collective.ldif
ldapadd    -Y EXTERNAL -H ldapi:/// -f  /etc/openldap/schema/corba.ldif
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f ldiffile/base.ldif
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f ldiffile/users.ldif
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f ldiffile/groups.ldif
ldapadd -h localhost -p 389 -D cn=root,dc=c9lab,dc=oracle,dc=com -w welcome1 -f ldiffile/sudogroup.ldif
!
