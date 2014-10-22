define deploy::resource::symlink (
  $original_name,
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
  $id = $original_name,
) {

  file { $id:
    ensure => $ensure,
    target => $target,
    owner => $user,
    group => $group,
    require => $require,
    force => $force,
  }
}
