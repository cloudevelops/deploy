define deploy::resource::directory (
  $user_default,
  $group_default,
  $mode_default,
  $ensure = 'directory',
  $user = $user_default,
  $group = $group_default,
  $mode = $mode_default,
  $require = undef,
) {

  file {
    $name:
      ensure => $ensure,
      owner => $user,
      group => $group,
      require => $require,
      mode => $mode,
  }
}
