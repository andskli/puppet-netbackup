class netbackup::client::install (
  $installer_path       = undef,
  $netbackup_version    = undef,
  $netbackup_master     = "netbackup.${::domain}",
  $netbackup_clientname = "${::fqdn}",
){

  file { 'install_netbackup_client.expect':
    path     => '/tmp/install_netbackup_client.expect',
    owner    => 'root',
    group    => 'root',
    mode     => '0744',
    content  => template('netbackup/install_netbackup_client.expect.erb'),
  }

  package { 'expect':
    ensure => installed,
  }
  exec { 'run-netbackup-install':
    command  => 'expect /tmp/install_netbackup_client.expect',
    path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require  => [Package['expect'], File['install_netbackup_client.expect']],
    unless   => "grep ${netbackup_version} /usr/openv/netbackup/bin/version",
  }

}
