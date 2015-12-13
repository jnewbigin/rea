# main puppet manifest
# Author: John Newbigin
# we are using this locally rather than with a puppet-master

# Set some defaults
Notify{ withpath => false }

# Some generic helper types
define print() {
        notify{$name:
                message => "-> $name",
        }
}

# We don't have a host name so we are just going to configure default
node 'default' {
	# load modules which define resource types
	include git
	include sinatra

	# configuration for this node
        include baseline_server

	# add on a web server
	include web_server
	include web_server::firewall
	include web_server::passenger

	# and deploy this app
	include app_hello_world
}

