define deploy::application (
  $application,
  $hiera_scope,
  $role,
  $original_name,
  $configure_services = false,
) {

  $application_role = $original_name

  if ($role == $application_role) {
    notify{"application role ok: ${application_role}":}
  }

}