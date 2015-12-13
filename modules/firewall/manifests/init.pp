# Manage the firewall daemon and rulles
# Author: John Newbigin

# Configure to allow a pre-defined service on the specified zone
define firewall::allow_service($service = $name, $zone = "public") {
	exec { "Allow $service on $zone":
		command => "/usr/bin/firewall-cmd --permanent --zone=$zone --add-service $service",
		unless => "/usr/bin/firewall-cmd --permanent --zone=$zone --query-service $service",
		notify => Class['firewall::apply'],
	}
}

# Load the permanent firewall rules to be the running rules
# This will only run if the permanent rules have been altered by puppet
class firewall::apply {
	exec { "Applying firewall rules":
		command => "/usr/bin/firewall-cmd --reload",
		refreshonly => true,
	}
}

# Register the apply class
class firewall {
	include firewall::apply
}

