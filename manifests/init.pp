# == Class: deploy
#
# Full description of class deploy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'deploy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class deploy (
  $application = {},
  $hiera_scope = $deploy::params::hiera_scope,
  $private_key,
  $public_key,
  $role = $deploy::params::role,
  $user = $deploy::params::user,
  $group = $deploy::params::group,
  $secondary_group = undef,


) inherits deploy::params {

  class {'deploy::user': }

  $role_default = {
    hiera_scope => $hiera_scope,
    role => $role,
  }

  create_resources('deploy::role',$application,$role_default)

}
