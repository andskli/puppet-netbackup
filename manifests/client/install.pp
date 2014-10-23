class netbackup::client::install (
  $installer_path       = '/mnt/install/netbackup/clients/install',
  $netbackup_version    = '7.6.0.2',
  $netbackup_master     = "netbackup.${::domain}",
  $netbackup_clientname = "${::fqdn}",
){

  $installer_os = $::kernel ? {
    'Linux' => 'Linux',
    default => 'Linux',
  }

  $installer_dist = $::osfamily ? {
    'Debian' => 'Debian',
    'RedHat' => 'RedHat',
    default  => undef,
  }

  # @todo FIXME
  $installer_minversion = $::osfamily ? {
    'Debian' => '2.6.18',
    'RedHat' => '2.6.18',
    'SuSE'   => '2.6.16',
  }

  file { '/tmp/install_netbackup_client.expect':
    owner    => 'root',
    group    => 'root',
    mode     => '0744',
    content  => template('netbackup/install_netbackup_client.expect.erb'),
  }

  exec { 'run-netbackup-install':
    command  => 'expect /tmp/install_netbackup_client.expect',
    path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    requires => Package['expect'],
    onlyif   => "grep -v ${netbackup_version} /usr/openv/netbackup/bin/version",
  }

}
