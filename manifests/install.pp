define deploy::install (
  $artefact,
  $artefact_type,
  $version,
) {

  case $artefact_type {
    'package': {
      package { $artefact:
        ensure => $version
      }
    }
  }

}
