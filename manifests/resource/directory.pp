define deploy::resource::directory (
  $original_name,
  $user_default,
  $group_default,
  $mode_default,
  $ensure = 'directory',
  $user = $user_default,
  $group = $group_default,
  $mode = $mode_default,
  $require = undef,
  $id = $original_name,
) {

  file { $id:
    ensure => $ensure,
    owner => $user,
    group => $group,
    require => $require,
    mode => $mode,
  }
}
