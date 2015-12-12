# Set some defaults
Notify{ withpath => false }

# Some generic helper types
define print() {
        notify{$name:
                message => "-> $name",
        }
}

node 'default' {
	# load modules which define resource types
	include git
	include sinatra

	# configuration for this node
        include baseline_server
	include web_server
	include web_server::firewall
	include web_server::passenger
	include app_hello_world
}

