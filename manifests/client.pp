class netbackup::client (
  $installer         = undef,
  $version           = undef,
  $clientname        = "${::fqdn}",
  $masterserver      = "netbackup.${::domain}",
  $mediaservers      = undef,
  $service_enabled   = true,
) {

  class { 'netbackup::client::install': }

  file { 'bp.conf':
    ensure        => file,
    path          => '/usr/openv/netbackup/bp.conf',
    owner         => 'root',
    group         => 'root',
    mode          => '0644',
    content       => template('netbackup/bp.conf.erb'),
  }

  service { 'netbackup':
    ensure        => $service_enabled,
    name          => 'netbackup',
    hasrestart    => false,
    hasstatus     => false,
    pattern       => 'bpcd',
    require       => Class['netbackup::client::install'],
  }

}
