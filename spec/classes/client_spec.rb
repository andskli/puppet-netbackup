require 'spec_helper'
describe 'netbackup::client' do

  let(:params) {
    {
      :installer       => '/tmp/installer.expect',
      :version         => '7.6.0.1',
      :masterserver    => 'netbackup.xyz.com',
      :clientname      => 'spectest.xyz.com',
      :service_enabled => true,
    }
  }

  it do
    should contain_class("netbackup::client::install").with({
      'installer'    => '/tmp/installer.expect',
      'version'      => '7.6.0.1',
      'masterserver' => 'netbackup.xyz.com',
      'clientname'   => 'spectest.xyz.com',
    })
  end

  context 'with same version already installed' do

   let(:facts) {
     {
       :netbackup_version => '7.6.0.1',
     }
   }

   let(:params) {
     {
       :version => '7.6.0.1',
     }
   }

   it do
      should_not contain_class("netbackup::client::install")
      should contain_service("netbackup-client").with({
        'name'   => 'netbackup',
        'ensure' => 'true',
      })
   end

  end

  context 'with newer version already installed' do

    let(:facts) {
      {
        :netbackup_version => '7.6.0.3',
      }
    }

    let(:params) {
      {
        :version => '7.6.0.1',
      }
    }

    it do
      should_not contain_class("netbackup::client::install")
    end

  end

  context 'with older version already installed' do
 
    let(:facts) {
      {
        :netbackup_version => "7.5.0.0",
      }
    }

    it do
      should contain_service("netbackup-client").with({
        'name'   => 'netbackup',
        'ensure' => 'true',
      })
      should contain_class("netbackup::client::install")
    end
  end

end

describe 'netbackup::client::install' do

  let(:params) {
    {
      :installer    => '/tmp/install_netbackup_client.expect',
      :version      => '7.6.0.1',
      :masterserver => 'netbackup.xyz.com',
      :clientname   => 'spectest.xyz.com',
    }
  }

  it do
    should contain_file('install_netbackup_client.expect').with({
      'path'    => '/tmp/install_netbackup_client.expect',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0744',
      'content' => /netbackup.xyz.com/,
    })
  end

end
