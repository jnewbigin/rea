# Simple yum command wrappers
# Author: John Newbigin

# Ensure that all packages are up to date
class yum::update {
	exec { "yum update":
		command => "/usr/bin/yum -y update",
	}
}

# Ensure the kernel is up to date and detect if
# a reboot is required to activate it
class yum::kernel {
	package { "kernel":
		ensure => latest,
	} ->
	exec { "kernel version check":
		provider => shell,
		command => "if [ $(grubby --default-kernel | cut -d - -f 2- ) != $(uname -r) ] ; then echo 'Reboot required to activate kernel' ; fi",
		logoutput => true,
	}
}

# Nothing to do here
class yum {
}
