class netbackup::client (
  $installer         = undef,
  $version           = undef,
  $clientname        = $::fqdn,
  $masterserver      = "netbackup.${::domain}",
  $mediaservers      = undef,
  $service_enabled   = true,
) {

  #class { 'netbackup::client::install': }
  if $::netbackup_version == undef {
    include netbackup::client::install
  }

  if versioncmp($version, $::netbackup_version) < 1 {
    notice("Installed version ${::netbackup_version} newer or equal to ${version}, not installing")
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

  service { 'netbackup':
    ensure     => $service_enabled,
    name       => 'netbackup',
    hasrestart => false,
    hasstatus  => false,
    pattern    => 'bpcd',
    onlyif     => 'test -f /etc/init.d/netbackup',
  }

}
