define deploy::application (
  $application,
  $hiera_scope,
  $role,
  $original_name,
  $configure_services = false,
) {

  $application_role = $original_name
  if ($role == $application_role) {
#    notify{"application role ok: ${application_role}":}

    $type = hiera("${hiera_scope}${application}::type",'package')
    $branch = hiera("${hiera_scope}${application}::branch",'')
    $version = hiera("${hiera_scope}${application}::version",'1.0-1')

    file {"/var/lib/appdeploy/${application}.info":
      ensure => present,
      content => "Application: ${application}
Role: ${role}
Type: ${type}
Branch: ${branch}
Version: ${version}\n"
    }
  }

}