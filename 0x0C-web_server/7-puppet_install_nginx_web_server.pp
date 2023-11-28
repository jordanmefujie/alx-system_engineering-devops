#!/usr/bin/env bash

class nginx {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-available/default':
    ensure => present,
    content => template('nginx_config/default.erb'),
    notify => Service['nginx'],
  }

  file { '/var/www/html/index.html':
    ensure  => present,
    content => "Hello World!\n",
    require => Package['nginx'],
  }
}

class { 'nginx': }

# Redirect configuration
nginx::resource::vhost { 'redirect_me':
  www_root  => '/var/www/html',
  ensure    => present,
  port      => '80',
  priority  => '10',
  server_name => ['_'],
  location   => [
    {
      'location' => '~^/redirect_me',
      'ensure'   => 'present',
      'content'  => 'return 301 http://example.com;'
    },
  ],
}
