define deploy::resource::config (
  $mysql_resource,
  $file,
  $template,
  $user_default,
  $group_default,
  $mode_default,
  $user = $user_default,
  $group = $group_default,
  $mode = $mode_default,
) {

  file { '$file':
    ensure => present,
    owner => $user,
    group => $group,
    mode => $mode,
    content => template($template)
  }

}
