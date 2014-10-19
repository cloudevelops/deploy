class deploy::user (
  $private_key     = $deploy::private_key,
  $public_key      = $deploy::public_key,
  $user            = $deploy::user,
  $group           = $deploy::group,
  $secondary_group = $deploy::secondary_group,
) {

  if $secondary_group {
    $files_group = $secondary_group
  } else {
    $files_group = $group
  }

  if (! defined(Group[$group])) {
    group {
      $group:
        ensure => present;
    }
  }

  user {
    $user:
      ensure   => $presence,
      home     => "/var/lib/${user}",
      shell    => '/bin/bash',
      gid      => $group,
      groups   => $files_group,
      password => '!';
  }

  file {
    "/var/lib/${user}":
      ensure => directory,
      mode   => '0600',
      owner  => $user,
      group  => $group;
    "/var/lib/${user}/.ssh":
      ensure => directory,
      mode   => '0600',
      owner  => $user;
    "/var/lib/${user}/.ssh/authorized_keys":
      ensure => present,
      source => $public_key,
      owner  => $user,
      mode   => '0600';
    "/var/lib/${user}/.ssh/id_rsa":
      ensure => present,
      source => $private_key,
      owner  => $user,
      mode   => '0600';
    "/var/lib/${user}/.ssh/config":
      ensure => present,
      source => 'puppet:///modules/deploy/ssh/config',
      owner  => $user,
      mode   => '0600';
  }

  sudo::conf { $user:
    priority => 10,
    content  => "${user} ALL=(ALL) NOPASSWD: ALL\n",
  }

}
