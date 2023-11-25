#!/usr/bin/env bash
# using puppet to connect without password

# Ensure the directory ~/.ssh exists
file { '/home/ubuntu/.ssh':
  ensure => directory,
}

# Ensure the SSH client configuration file exists
file { '/home/ubuntu/.ssh/config':
  ensure  => present,
  mode    => '0600',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  content => template('2-ssh_config/ssh_config.erb'),
}

# Configure the SSH client
file_line { 'Turn off passwd auth':
  path  => '/home/ubuntu/.ssh/config',
  line  => 'PasswordAuthentication no',
  match => '^#PasswordAuthentication',
}

file_line { 'Declare identity file':
  path  => '/home/ubuntu/.ssh/config',
  line  => 'IdentityFile ~/.ssh/school',
  match => '^#IdentityFile',
}
