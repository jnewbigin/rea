# Install and configure mod_passenger addon for apache
# Auther: John Newbigin

# Install the passenger yum repository as per
# https://www.phusionpassenger.com/library/install/apache/install/oss/el7/
class web_server::passenger::repo {
	exec { "Add passenger repo":
		command => "/usr/bin/curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo",
		creates => "/etc/yum.repos.d/passenger.repo",
	}
}

# Install the required packages
# will also enable EPEL and passenger repos
class web_server::passenger::install {
	include web_server::passenger::repo

	package { "epel-release": ensure => present, }
	package { "pygpgme": ensure => present, }
	package { "curl": ensure => present, }
	package { "rubygems": ensure => latest, }
	package { "mod_passenger": 
		ensure => latest,
		require => [ 
			Class['web_server::passenger::repo'], 
			Package['epel-release'], 
		],
	}
	package { "rubygem-bundler": ensure => latest, }

	# /usr/bin/passenger-config validate-install --auto

}

class web_server::passenger {
        include web_server::passenger::install
}

