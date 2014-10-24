class netbackup::client (
  $installer         = undef,
  $version           = undef,
  $masterserver      = "netbackup.${::domain}",
  $clientname        = "${::fqdn}",
  $service_enabled   = true,
) {

  class { 'netbackup::client::install': }

  file { 'bp.conf':
    path          => '/usr/openv/netbackup/bp.conf',
    ensure        => 'file',
  }

  service { 'netbackup':
    name          => 'netbackup',
    ensure        => $service_enabled,
    hasrestart    => false,
    hasstatus     => false,
    pattern       => 'bpcd',
    require       => Class['netbackup::client::install'],
  }

}
