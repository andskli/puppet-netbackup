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
    should contain_service("netbackup").with({
      'name'   => 'netbackup',
      'ensure' => 'true',
    })
  end

end
