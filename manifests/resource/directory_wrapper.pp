define deploy::resource::directory_wrapper (
  $directory_resource,
  $directory_defaults,
  $directory_id
) {

  create_resources_append('deploy::resource::directory',$directory_resource,$directory_defaults,$directory_id)

}
