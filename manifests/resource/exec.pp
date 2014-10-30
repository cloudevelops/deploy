define deploy::resource::exec (
  $original_name,
  $command,
  $env_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  $id,
  $user_default,
  $group_default,
  $path_default,
  $user = $user_default,
  $group = $group_default,
  $cwd = $path_default,
) {

  exec { $name:
    refreshonly => true,
    user => $user,
    environment => ['HOME=/var/lib/deploy'],
    command => $command,
    path => $env_path,
    cwd => $cwd,
    subscribe => File["/var/lib/${deploy::user}/${id}.json"],
    require => [ File["/var/lib/${deploy::user}/${id}.json"] ];
  }

}
