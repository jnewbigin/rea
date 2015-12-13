# sinatra is a ruby web framework
# we need to tewak a few thing to get it to work with passenger
# Author: John Newbigin

# deploy/enable a web app to be served with mod_passenger
# $dir should be the path to the config.ru file
define sinatra::deploy($dir = $name, $url = "/") {
	include web_server::passenger
	exec { "bundle $name":
		cwd => $dir,
		command => "/usr/bin/bundle install",
		require => [
			Package['rubygem-bundler'],
			Class['web_server::passenger'],
		],
	} ->
	file { "$dir/public":
		ensure => directory,
	} ->
	file { "$dir/tmp":
		ensure => directory,
	}
	if($url == "/") {
		# patch into the web server config
		web_server::document_root{"$dir/public": 
			notify => Service['httpd'],
			require => File["$dir/public"],
		} 
		print{"$name is now available at http://$fqdn/": }
	} else {
		print{"Non-root URL is NYI": }
	}
}

# nothing to do here
class sinatra {
}
