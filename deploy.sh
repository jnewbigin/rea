#!/bin/bash

# deploy.sh
# Provision application server and deploy sinatra based hello_world application
# Written by John Newbigin

# Written for and tested on CentOS-7 minimal install
# You must enable the network:
#  nmcli con add ifname eth0 type ethernet
# you will probably do that to get this script on

# Install puppet yum repository
# (ideal world, puppet is in our localally controlled rpm repo)
# also ideal, we install puppet from our kickstart install script
rpm -q puppetlabs-release || yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
rpm -q puppet || yum -y install puppet

# mod_passenger requires this latest selinux-policy patch which is not released yet
# (should download to our local repo)
rpm -q selinux-policy-3.13.1-60.el7 || yum -y update http://buildlogs.centos.org/c7.1511.00/selinux-policy/20151120104451/3.13.1-60.el7.x86_64/selinux-policy-3.13.1-60.el7.noarch.rpm http://buildlogs.centos.org/c7.1511.00/selinux-policy/20151120104451/3.13.1-60.el7.x86_64/selinux-policy-targeted-3.13.1-60.el7.noarch.rpm

if [ -x /usr/bin/puppet ] ; then
   # clean up in case there was a failed attempt
   #find /var/lib/puppet/ssl -type f -exec rm "{}" ";"

   # ideal world, we would register with our puppet master here
   # puppet agent --server=puppet-master --no-daemonize --verbose --onetime --waitforcert 30"

   # We don't have a puppet server so we are just going to use local files
   /usr/bin/puppet apply --modulepath=modules site.pp
else
   echo "Error installing puppet"
   exit 1
fi

