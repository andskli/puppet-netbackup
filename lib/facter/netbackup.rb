Facter.add('netbackup_client_name') do
  setcode do
    client_name = Facter::Util::Resolution.exec('/usr/openv/netbackup/bin/nbgetconfig CLIENT_NAME')
    client_name.split[2]
  end
end

Facter.add('netbackup_serverlist') do
  setcode do
    server_rows = Facter::Util::Resolution.exec('/usr/openv/netbackup/bin/nbgetconfig SERVER').split("\n")
    servers = server_rows.map! { |x| x.split[2] }
    servers
  end
end
