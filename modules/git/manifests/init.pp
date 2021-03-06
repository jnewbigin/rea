# module git
# A collection of types to help manage git repositories
# Author: John Newbigin

# Ensure that git is installed
# This is included by types that require it so if it is
# not needed it will not be installed
class git::install {
	package { "git": ensure => present, }
}

# clone a git repository and checkout the desired branch
# if the destination alreay exists then no clone is performed
# if you want to update an existing checkout, use git::pull
define git::clone($url, $destination, $branch = "master") {
	include git::install
	exec { "git clone $name":
		command => "/usr/bin/git clone -b '$branch' '$url' '$destination'",
		creates => "$destination/.git",
		require => Package['git'],
	} 
}

# perform a pull on a checked out git repository
define git::pull($destination = $name, $repository = "origin", $refspec = "master") {
	include git::install
	exec { "git pull $name":
		cwd => $destination,
		command => "/usr/bin/git pull '$repository' '$refspec'",
		requires => Package['git'],
	}
}

class git {
	# nothing to do here
}

