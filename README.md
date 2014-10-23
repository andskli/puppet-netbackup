# netbackup

1. [Overview](#overview)
    * [Client](#client)
    * [Server](#server)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

Puppet + NetBackup

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

### Server

Only handles preparation for NetBackup Master/media installation for now, see `netbackup::server::prepare`.

## Usage

Sample definition:

    class { 'netbackup::client':
        installer       => '/path/to_nfs_share/NetBackup_7.6.0.1_CLIENTS2/install',
        version         => '7.6.0.1',
        service_enabled => true,
        masterserver    => 'netbackup.xyz.com',
    }


## Limitations

Only tested on Linux for now.

## Development

Standard GitHub workflow, i.e.

1. Fork/branch
2. Send PR
3. Wait for response
