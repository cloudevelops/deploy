define deploy::application (
  $id,
  $hiera_scope,
  $role,
  $original_name,
  $run = false,
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

  }

}