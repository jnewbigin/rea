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
		} 
	} else {
		print{"Non-root URL is NYI": }
	}
}

class sinatra {
}
