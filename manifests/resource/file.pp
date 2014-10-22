define deploy::resource::file (
  $original_name,
  $mysql_resource,
  $memcache_resource,
  $memcacheq_resource,
  $rabbitmq_resource,
  $mongo_resource,
  $graylog_resource,
  $api_resource,
  $config_resource,
  $template,
  $user_default,
  $group_default,
  $mode_default,
  $user = $user_default,
  $group = $group_default,
  $mode = $mode_default,
  $id = $original_name,
) {

  file { $id:
    ensure => present,
    owner => $user,
    group => $group,
    mode => $mode,
    content => template($template)
  }

}
