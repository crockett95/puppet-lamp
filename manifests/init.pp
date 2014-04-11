# == Class: lamp
#
# Provisions a simple server stack for Apache, MySQL and PHP on Ubuntu.
# Designed to be run with Vagrant for development environments.
#
# === Parameters
#
# None presently
#
# === Variables
#
# None presently
#
# === Examples
#
#  include lamp
#
# === Authors
#
# Steve Crockett <crockett95@gmail.com>
#
# === Copyright
#
# Copyright 2014 Steve Crockett.
#
class lamp {
	class { 'apt' :
		before => [ Class['apache'], Class['php'], Class['mysql::server'] ]
	}

	/*
	 *	Start Apache config
	 */
	class { 'apache' :
		mpm_module	=>	'prefork',
	}

	# Apache Mods
	class { 'apache::mod::php' : }
	class { 'apache::mod::rewrite' : }


	/*
	 *	Start PHP Config
	 */
	class { 'php' :
		service =>	'httpd',
	}

	# PHP Modules
	php::module { 'mcrypt' : }
	php::module { 'gd' : }
	php::module { 'mysql' : }


	/*
	 *	Start MySQL Config
	 */
	class { 'mysql::server' :
		root_password 	=>	'root',
	}

}
