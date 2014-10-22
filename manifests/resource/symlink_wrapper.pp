define deploy::resource::symlink_wrapper (
  $symlink_resource,
  $symlink_defaults,
  $symlink_id
) {

  create_resources_append('deploy::resource::symlink',$symlink_resource,$symlink_defaults,$symlink_id)

}
