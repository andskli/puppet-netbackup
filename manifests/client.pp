class netbackup::client (
  $installer         = undef,
  $version           = undef,
  $clientname        = $::fqdn,
  $masterserver      = undef,
  $mediaservers      = undef,
  $service_enabled   = true,
  $excludes          = undef,
) {

  if versioncmp($version, $::netbackup_version) < 1 {
    notice("Installed version ${::netbackup_version} newer or equal to ${version}, not installing")
  }
  if versioncmp($version, $::netbackup_version) == 1 {
    notice ("Found NetBackup version: ${::netbackup_version}, have newer ${version} which I'll install using class netbackup::client::install")
    class { 'netbackup::client::install': }
  }

  file { '/usr/openv/netbackup':
    ensure => directory,
  }

  file { 'bp.conf':
    ensure  => file,
    path    => '/usr/openv/netbackup/bp.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('netbackup/bp.conf.erb'),
    require => File['/usr/openv/netbackup'],
  }

  # Only define netbackup init service if netbackup_version fact is set
  if $::netbackup_version != undef {
    service { 'netbackup-client':
      ensure     => $service_enabled,
      name       => 'netbackup',
      hasrestart => false,
      hasstatus  => false,
      pattern    => 'bpcd',
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
