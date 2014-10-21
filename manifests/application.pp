define deploy::application (
  $id,
  $hiera_scope,
  $role,
  $original_name,
  $run = false,
  $exported_resources = $run,
  $local_resources = $run,
) {

  $application_role = $original_name
  if ($role == $application_role) {
#    notify{"application role ok: ${application_role}":}

    $artefact = hiera("${hiera_scope}${id}::artefact")
    $artefact_type = hiera("${hiera_scope}${id}::artefact_type",'package')
    $branch = hiera("${hiera_scope}${id}::branch")
    $build = hiera("${hiera_scope}${id}::build",'1')
    $path = hiera("${hiera_scope}${id}::path")
    $version = hiera("${hiera_scope}${id}::version")
    $user = hiera("${hiera_scope}${id}::user",$deploy::user)
    $group = hiera("${hiera_scope}${id}::group",$deploy::group)
    $mode = hiera("${hiera_scope}${id}::mode",$deploy::mode)
    $mysql_resource = hiera("${hiera_scope}${id}::mysql_resource",{})
    $vhost_resource = hiera("${hiera_scope}${id}::vhost_resource",{})
    $upstream_resource = hiera("${hiera_scope}${id}::upstream_resource",{})
    $configfile_resource = hiera("${hiera_scope}${id}::configfile_resource",{})
    $memcache_resource = hiera("${hiera_scope}${id}::memcache_resource",{})
    $memcacheq_resource = hiera("${hiera_scope}${id}::memcacheq_resource",{})
    $rabbitmq_resource = hiera("${hiera_scope}${id}::rabbitmq_resource",{})
    $mongo_resource = hiera("${hiera_scope}${id}::mongo_resource",{})
    $graylog_resource = hiera("${hiera_scope}${id}::graylog_resource",{})
    $api_resource = hiera("${hiera_scope}${id}::api_resource",{})
    $config_resource = hiera("${hiera_scope}${id}::config_resource",{})
    $exec_resource = hiera("${hiera_scope}${id}::exec_resource",{})

    file {"/var/lib/${deploy::user}/${id}.json":
      ensure => present,
      require => File["/var/lib/${deploy::user}"],
      content => template('deploy/application/application.json.erb'),
    }

    deploy::install{ $id:
      artefact => $artefact,
      artefact_type => $artefact_type,
      version => $version,
      path => $path,
      user => $user,
      group => $group,
      mode => $mode,
    }

    if $run {

      if $local_resources {
        $configfile_defaults = {
          mysql_resource => $mysql_resource,
          memcache_resource => $memcache_resource,
          memcacheq_resource => $memcacheq_resource,
          rabbitmq_resource => $rabbitmq_resource,
          mongo_resource => $mongo_resource,
          graylog_resource => $graylog_resource,
          api_resource => $api_resource,
          config_resource => $config_resource,
          user_default => $user,
          group_default => $group,
          mode_default => $mode,
        }
        create_resources_append('deploy::resource::configfile',$configfile_resource,$configfile_defaults,"#${name}@${fqdn}")
        $exec_defaults = {
          id => $id,
          path_default => $path,
          user_default => $user,
          group_default => $group,
        }
        create_resources_append('deploy::resource::exec',$exec_resource,$exec_defaults,"#${name}@${fqdn}")
      }

      if $exported_resources {
        create_resources_append('deploy::resource::mysql',$mysql_resource,{},"#${name}@${fqdn}")
        create_resources_append('deploy::resource::vhost',$vhost_resource,{},"#${name}@${fqdn}")
        create_resources_append('deploy::resource::upstream',$upstream_resource,{},"#${name}@${fqdn}")
      }

    }

  }

}