define deploy::resource::vhost (
  $original_name,
  $id,
  $vhost_service,
  $upstream = undef,
  $vhost_type = 'html',
  $server_name,
  $rewrite_alias = undef,
  $www_root = undef,
  $ssl_domain = undef,
  $ssl_only = undef,
  $static_location = undef,
  $fastcgi_cache = undef,
  $rewrite = undef,
  $location_custom_cfg_prepend = undef,
  $location_custom_cfg_append = undef,
  $access_log = undef,
  $static_location_custom_cfg = undef,
  $deny_location = undef,
  $rewrite_vhost = undef,
  $add_location = undef,
  $extra_location = undef,
) {

  case $vhost_service {
    'nginx': {

#      notify{"vhost_resource name: ${name}, original_name: ${original_name}, id: ${id}, vhost_service: ${hostname}, deny_location: ${deny_location}": }

      @@nginx_base::resource::exported_vhost { $name:
        environment => $environment,
        nginx_service => $original_name,
        upstream => $upstream,
        vhost_type => $vhost_type,
        id => $id,
        server_name => $server_name,
        rewrite_alias => $rewrite_alias,
        www_root => $www_root,
        ssl_domain => $ssl_domain,
        ssl_only => $ssl_only,
        static_location => $static_location,
        fastcgi_cache => $fastcgi_cache,
        rewrite => $rewrite,
        location_custom_cfg_prepend => $location_custom_cfg_prepend,
        location_custom_cfg_append => $location_custom_cfg_append,
        access_log => $access_log,
        static_location_custom_cfg => $static_location_custom_cfg,
        deny_location => $deny_location,
        rewrite_vhost => $rewrite_vhost,
        add_location => $add_location,
        extra_location => $add_location,
      }
    }
    'apache': {

#      notify{"vhost_resource name: ${name}, original_name: ${original_name}, id: ${id}, vhost_service: ${hostname}": }

      @@apache_base::resource::exported_vhost { $name:
        environment => $environment,
        apache_service => $original_name,
        upstream => $upstream,
        vhost_type => $vhost_type,
        id => $id,
        server_name => $server_name,
        rewrite_alias => $rewrite_alias,
        www_root => $www_root,
        ssl_domain => $ssl_domain,
        ssl_only => $ssl_only,
        static_location => $static_location,
        fastcgi_cache => $fastcgi_cache,
        rewrite => $rewrite,
        location_custom_cfg_append => $location_custom_cfg_append,
        access_log => $access_log,
        static_location_custom_cfg => $static_location_custom_cfg,
        deny_location => $deny_location,
      }
    }
  }
}
