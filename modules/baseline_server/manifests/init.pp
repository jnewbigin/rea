class baseline_server {
	print{ "Configuring baseline server": }
	# CentOS-7 is pretty much locked down out of the box
	# and there are no site specific requirements here
	include firewall
	include yum::update
	include yum::kernel

}

