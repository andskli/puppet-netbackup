class netbackup::client (
  $installer         = undef,
  $version           = undef,
  $masterserver      = "netbackup.${::domain}",
  $clientname        = "${::fqdn}",
  $service_enabled   = true,
) {

  service { 'netbackup':
    name          => 'netbackup',
    ensure        => $service_enabled,
    hasrestart    => false,
    hasstatus     => false,
    pattern       => "bpcd",
  }

}
