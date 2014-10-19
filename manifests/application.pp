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
    $path = hiera("${hiera_scope}${id}::path")
    $version = hiera("${hiera_scope}${id}::version")

    file {"/var/lib/${deploy::user}/${id}.json":
      ensure => present,
      require => File["/var/lib/${deploy::user}"],
      content => template('deploy/application/application.json.erb'),
    }

    deploy::install{ $id:
      artefact => $artefact,
      artefact_type => $artefact_type,
      version => $version
    }

  }

}