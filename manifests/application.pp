define deploy::application (
  $application,
  $hiera_scope,
  $role,
  $application_role = $original_name,
) {

  notify{"application start}":}

  if ($role == $application_role) {

    notify{"application role ok: ${application_role}":}

  }

}