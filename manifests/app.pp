# == Class: lamp
#
# Provisions an Apache Vhost and a MySQL database for local development
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
define lamp::app	( 
	$appname,
	$dbname		=>	$appname,
	$dbuser		=>	$appname,
	$dbpassword	=>	'password',
	$apppath	=>	'/vagrant/app',
	$rootdir	=>	'/vagrant',
	$hostip		=>	$ipaddress_eth1,
) {
	# Vhost
	apache::vhost { '${appname}.${hostip}.xip.io' :
		port		=>	'80',
		docroot		=>	$apppath,
		require		=>	Class[lamp],
		serveraliases	=>	'*.${appname}.${hostip}.xip.io',
		directories 	=> 	[
			{
				path	=>	$rootdir, 
	        	options => 	[ 'FollowSymLinks', 'MultiViews' ], 
			},
		],
	}

	# New Database
	mysql::db { $dbname :
		user 		=> 	$dbuser,
		password 	=> 	$dbpassword,
		host 		=> 	'localhost',
		grant 		=> 	['ALL'],
		require		=>	Class[lamp],
	}
}
