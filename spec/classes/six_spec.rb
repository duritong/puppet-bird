require 'spec_helper'
describe 'bird::six' do
  let(:facts) {
    {
      :ipaddress => '1.2.3.4',
    }
  }
  context 'with default values for all parameters' do
    it { should contain_class('bird::six') }
    it { should compile.with_all_deps }
    it { should contain_package('bird6').with(
      :ensure => 'installed',
      :before => ['File[/etc/bird6.conf]'],
    ) }
    it { should contain_file('/etc/bird6.conf').with(
      :owner  => 'root',
      :group  => 'bird6',
      :mode   => '0640',
      :notify => 'Service[bird6]',
      :before => ['File[/etc/bird6.d]'],
    )}
    it { should contain_file('/etc/bird6.conf').with_content(/^router id 1\.2\.3\.4;$/)}
    it { should contain_file('/etc/bird6.conf').with_content(/^include "\/etc\/bird6\.d\/\*\.conf";$/)}
    it { should contain_file('/etc/bird6.d').with(
      :ensure  => 'directory',
      :purge   => true,
      :recurse => true,
      :force   => true,
      :owner   => 'root',
      :group   => 'bird6',
      :mode    => '0640',
      :notify  => ['Service[bird6]'],
    )}
    it { should contain_service('bird6').with(
      :ensure => 'running',
      :enable => true,
    ) }
  end
end
