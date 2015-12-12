# Install and configure mod_passenger

class web_server::passenger::repo {
	exec { "Add passenger repo":
		command => "/usr/bin/curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo",
		creates => "/etc/yum.repos.d/passenger.repo",
	}
}

#define gem() {
#	exec { "install gem $name":
#		command => "/usr/bin/gem install $name",
#		requires => Package['gem'],
#	}
#}

class web_server::passenger::rails {
#	gem { "rails": }
}

#DocumentRoot "/var/www/sinatra/public"
#RailsEnv development

class web_server::passenger::install {
	include web_server::passenger::repo
	include web_server::passenger::rails

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

        #file { "/etc/httpd/conf.d/passenger.conf":
        #        ensure => present,
        #        owner => 'root',
        #        group => 'root',
        #        mode => 0644,
        #        source => "puppet:///modules/web_server/passenger.conf",
        #        require => Class['web_server::install'],
        #}
}

