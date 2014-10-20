define deploy::application (
  $id,
  $hiera_scope,
  $role,
  $original_name,
  $run = false,
  $exported_resources = $run,
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

      if $exported_resources {
        create_resources_append('deploy::resource::mysql',$mysql_resource,{},"#${name}@${fqdn}")
        create_resources_append('deploy::resource::vhost',$vhost_resource,{},"#${name}@${fqdn}")
        create_resources_append('deploy::resource::upstream',$upstream_resource,{},"#${name}@${fqdn}")
      }

    }

  }

}