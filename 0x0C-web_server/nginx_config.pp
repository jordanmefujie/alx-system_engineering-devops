#!/usr/bin/env bash

# nginx_config.pp

class { 'nginx':
  package_name => 'nginx',
}

nginx::resource::vhost { 'default':
  ensure  => present,
  www_root  => '/var/www/html',
  port      => '80',
  server_name => ['_'],
  index_files => ['index.html'],
  location   => [
    {
      'location' => '/',
      'ensure'   => 'present',
      'content'  => 'return 200 "Hello World!";',
    },
    {
      'location' => '~^/redirect_me',
      'ensure'   => 'present',
      'content'  => 'return 301 http://example.com;',
    },
  ],
}
