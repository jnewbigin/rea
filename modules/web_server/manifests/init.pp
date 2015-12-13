
class web_server::install {
	package{ "httpd": 	ensure => latest, }
	package{ "httpd-tools": ensure => latest, }
}

class web_server::firewall {
}

class web_server::service {
        service { "httpd":
                ensure => running,
                hasstatus => true,
                hasrestart => true,
                enable => true,
                require => Class["web_server::config"],
        }
}

class web_server::config {
}

class web_server {
	include web_server::install
	include web_server::config
	include web_server::firewall
	include web_server::service
}
