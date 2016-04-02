class netbackup::client::config (
  $clientname        = $netbackup::client::clientname,
  $masterserver      = $netbackup::client::masterserver,
  $mediaservers      = $netbackup::client::mediaservers,
  $service_enabled   = $netbackup::client::service_enabled,
  $excludes          = $netbackup::client::excludes,
){

  file { 'bp.conf':
    ensure  => file,
    path    => '/usr/openv/netbackup/bp.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('netbackup/bp.conf.erb'),
  }

  # Only define netbackup init service if netbackup_version fact is set
  if $::netbackup_version != undef {
    service { 'netbackup-client':
      ensure     => $service_enabled,
      name       => 'netbackup',
      hasrestart => false,
      hasstatus  => false,
      pattern    => 'bpcd',
      provider   => init,
	  require    => File["bp.conf"]
    }
  }

  if $excludes != undef {
    file { 'exclude_list':
      ensure  => file,
      path    => '/usr/openv/netbackup/exclude_list',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('netbackup/exclude_list.erb'),
    }
  }
}
