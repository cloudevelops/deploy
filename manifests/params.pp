class deploy::params {

  $hiera_scope = "${organization}::application::"
  $role = $::hostgroup
  $user = 'deploy'
  $group = 'deploy'
  $mode = '660'

}