class baseline_server {
	# include puppet
	#include runlevel
	#include sysctl
	#include xinetd
	#include iptables
	#include ssh
	#include ssh_keys
	#include selinux
	#include yum
	#include ipv6
	print{ "Configuring baseline server": }

}

