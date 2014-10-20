define deploy::resource::upstream (
  $original_name,
  $upstream,
  $vhost_service,
  $environment,
  $hostname,
  $ipaddress,
  $port,
  $debug = false
) {

  case $vhost_service {
    'nginx': {

      notify{"upstream_resource name: ${name}, original_name: ${original_name}, upstream: ${upstream}, vhost_service: ${vhost_service}, hostname: ${hostname}": }

      @@nginx_base::resource::exported_upstream { $name:
        upstream => $upstream,
        nginx_service => $original_name,
        environment => $environment,
        hostname => $hostname,
        ipaddress => $ipaddress,
        port => $port,
        debug => $debug,
      }
    }
    'apache': {
#      not implemented yet
#      notify{"upstream_resource name: ${name}, original_name: ${original_name}, upstream: ${upstream}, vhost_service: ${vhost_service}, hostname: ${hostname}": }


    }
  }
}
