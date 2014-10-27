# puppet-netbackup


## Overview

Puppet + NetBackup. Currently in development, contributions are welcome. See [TODO](#todo) 

## TODO

- Server installation of master/media
- Tuning/parameterizing of master/media
- Policy creation/modification via puppet?
- Server facts
- Client facts
- Client upgrades
- ??

## Classes

The netbackup module provides the following classes of interest

- `netbackup::client` - used for client installation and management
- `netbackup::server::prepare` - used for master/media server preparation. Applies best practices for tuning such as changing sysctl and ulimit parameters.

### Client

Installs the client as neccessary on UNIX/Linux hosts, unfortunately using 
quite ugly expect script.

The `netbackup::client` class is used for management of NetBackup 
client. If no NetBackup client is present, it will try to run the NetBackup 
installer located at `installer` (should preferably be an NFS mount).

- `installer` - full path to the install binary provided from NetBackup DVD
- `version` - run install unless a client of this version is already installed
- `masterserver` - which masterserver should be entered upon installation of client
- `mediaservers` - mediaservers which has access to a client
- `service_enabled` - start netbackup, true or false?

#### Example usage

Sample definition:

    class { 'netbackup::client':
        installer       => '/path/to_nfs_share/NetBackup_7.6.0.1_CLIENTS2/install',
        version         => '7.6.0.1',
        service_enabled => true,
        masterserver    => 'netbackup.xyz.com',
        mediaservers    => ['mediasrv1.xyz.com', 'mediasrv2.xyz.com'],
    }


### Server

Only handles preparation for NetBackup Master/media installation for now, see `netbackup::server::prepare`.

#### Example usage

	class { 'netbackup::server::prepare': }



## Limitations

Only tested on Linux (CentOS/Ubuntu) for now.

## Development

Standard GitHub workflow, i.e.

1. Fork/branch
2. Send PR
3. Wait for response
