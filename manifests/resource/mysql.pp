define deploy::resource::mysql (
  $original_name,
  $id = undef,
  $hostname = undef,
  $port = 3306,
  $username,
  $password,
  $access_ip = $ipaddress,
  $schema_privilege = undef
) {
  # Validation
  if !empty($schema_privilege) {
    if !is_hash($schema_privilege) {
      fail("schema_privilege for application ${original_name} must be an hash")
    }
  }

  @@mysql_base::user { $name:
    environment => $environment,
    mysql_service => $original_name,
    user => $username,
    password => $password,
    host => $access_ip,
    schema_privilege => $schema_privilege,
  }

#  notify{"mysql_resource name: ${name}, original_name: ${original_name}, id: ${id}, hostname: ${hostname}": }

}
