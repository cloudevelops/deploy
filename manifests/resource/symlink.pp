define deploy::resource::symlink (
  $user_default,
  $group_default,
  $mode_default,
  $ensure = 'link',
  $target,
  $user = $user_default,
  $group = $group_default,
  $mode = $mode_default,
  $require = undef,
  $force = undef,
) {

  file { $name:
    ensure => $ensure,
    target => $target,
    owner => $user,
    group => $group,
    require => $require,
    force => $force,
  }
}
