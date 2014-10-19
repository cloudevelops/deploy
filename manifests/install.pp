define deploy::install (
  $id = name,
  $artefact,
  $artefact_type,
  $version,
  $path,
  $user,
  $group,
  $mode,
) {

  case $artefact_type {
    'package': {
      package { $artefact:
        ensure => $version
      }
    }
  }

  file { $path:
    ensure => directory,
    owner => $user,
    group => $group,
    mode => $mode,
  }

  exec { "${name}-chown":
    command => "chown ${user}:${group} * -R",
    refreshonly => true,
    cwd => $path,
    path    => $::path,
    subscribe => File["/var/lib/${deploy::user}/${id}.json"],
  }

  exec { "${name}-chmod":
    command => "chmod ${mode} * -R",
    refreshonly => true,
    cwd => $path,
    path    => $::path,
    subscribe => File["/var/lib/${deploy::user}/${id}.json"],
  }

}
