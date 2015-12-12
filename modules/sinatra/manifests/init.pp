define sinatra::deploy($dir = $name) {
	include web_server::passenger
	exec { "bundle $name":
		cwd => $dir,
		command => "/usr/bin/bundle install",
		require => [
			Package['rubygem-bundler'],
			Class['web_server::passenger'],
		],
		# we can get notified when the dir changes and only build then
	} ->
	file { "$dir/public":
		ensure => directory,
	} ->
	file { "$dir/tmp":
		ensure => directory,
	}
	# patch into the web server config
}

class sinatra {
}
