
class app_hello_world {
	$git = "https://github.com/tnh/simple-sinatra-app.git"
	$dir = "/var/www/hello_world"

	# Obtain the source via GIT
	git::clone{$module_name:
		url => $git,
		destination => $dir,
	} ->
	sinatra::deploy{$module_name:
		dir => $dir,
	}

}
