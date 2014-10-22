define deploy::resource::file_wrapper (
  $file_resource,
  $file_defaults,
  $file_id
) {

  create_resources_append('deploy::resource::file',$file_resource,$file_defaults,$file_id)

}
