define deploy::role (
  $hiera_scope,
  $role,
  $application = $name,
) {

  $application_role = hiera("${hiera_scope}${application}::role")

  if is_hash($hostgroup) {

    $application_default = {
      application => $application,
      hiera_scope => $hiera_scope,
      role => $role,
    }

    notify{"role, creating resources: ${application_role}":}
    create_resources_prepend('deploy::application',$application_role,$application_default,$application)

  }

}
