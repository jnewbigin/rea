# Deploy the hello_world app
# Author: John Newbigin

class app_hello_world {
	$git = "https://github.com/tnh/simple-sinatra-app.git"
	$dir = "/var/www/hello_world"

	# Obtain the source via GIT
	git::clone{$module_name:
		url => $git,
		destination => $dir,
		require => Package['httpd'], # Make sure httpd is installed first so we get to correct SElinux context
	} ->
	sinatra::deploy{$module_name:
		dir => $dir,
	}

}
