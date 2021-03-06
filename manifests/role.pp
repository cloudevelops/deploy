define deploy::role (
  $hiera_scope,
  $role,
  $application = $name,
) {

  $application_role = hiera("${hiera_scope}${name}::role")
#  notify {"application_role:${application_role}": }

  if is_hash($application_role) {

    $application_default = {
      id => $name,
      hiera_scope => $hiera_scope,
      role => $role,
    }

#    notify{"role, creating resources: ${application_role}":}
    create_resources_prepend('deploy::application',$application_role,$application_default,"-${name}")

  }

}
