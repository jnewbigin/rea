# manage a local apache web server (httpd)
# Author: John Newbigin

# Add or update a web server directive
define web_server::directive($directive = $name, $value, $file = "/etc/httpd/conf/httpd.conf") {
        augeas { "web_server::directive $name add":
                context => "/files$file",
                changes => [
                        "set directive[last() +1] '$directive'",
                        "set directive[last()]/arg '$value'",
                ],
                onlyif => "match directive[. = '$directive']/arg size == 0",
                require => Package['httpd'],
		notify => Service['httpd'],
        } ->
        augeas { "web_server::directive $name update":
                context => "/files$file",
                changes => [
                        "set directive[. = '$directive']/arg '$value'",
                ],
                require => Package['httpd'],
		notify => Service['httpd'],
        }
}

# Set the document root for the main web server
define web_server::document_root() {
	directive{ "DocumentRoot":
		value => $name,
	}
}

# Install the required packages
class web_server::install {
	package{ "httpd": 	ensure => latest, }
	package{ "httpd-tools": ensure => latest, }
}

# Open the firewall
class web_server::firewall {
	firewall::allow_service {"http":
	}
}

# Ensure the service is enabled and running
class web_server::service {
        service { "httpd":
                ensure => running,
                hasstatus => true,
                hasrestart => true,
                enable => true,
                require => Class["web_server::config"],
        }
}

# No default config is required ATM
class web_server::config {
}

class web_server {
	include web_server::install
	include web_server::config
	include web_server::firewall
	include web_server::service
}
