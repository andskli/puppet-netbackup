class netbackup::client (
  $installer         = undef,
  $version           = undef,
  $clientname        = $::fqdn,
  $masterserver      = undef,
  $mediaservers      = undef,
  $service_enabled   = true,
  $excludes          = undef,
  $tmpinstaller      = '/tmp'
)
{

  if versioncmp($version, $::netbackup_version) < 1 {
    notice("Installed version ${::netbackup_version} newer or equal to ${version}, not installing")
    class { 'netbackup::client::config': }
  }
  else {
    notice ("Found NetBackup version: ${::netbackup_version}, have newer ${version} which I'll install using class netbackup::client::install")
    class { 'netbackup::client::install': } -> class { 'netbackup::client::config': }
  }
}
