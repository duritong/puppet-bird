require 'spec_helper'
describe 'bird' do
  let(:facts) {
    {
      :ipaddress => '1.2.3.4',
    }
  }
  context 'with default values for all parameters' do
    it { should contain_class('bird') }
    it { should compile.with_all_deps }
    it { should contain_package('bird').with(
      :ensure => 'installed',
      :before => ['File[/etc/bird.conf]'],
    ) }
    it { should contain_file('/etc/bird.conf').with(
      :owner  => 'root',
      :group  => 'bird',
      :mode   => '0640',
      :notify => 'Service[bird]',
      :before => ['File[/etc/bird.d]'],
    )}
    it { should contain_file('/etc/bird.conf').with_content(/^router id 1\.2\.3\.4;$/)}
    it { should contain_file('/etc/bird.conf').with_content(/^include "\/etc\/bird\.d\/\*\.conf";$/)}
    it { should contain_file('/etc/bird.d').with(
      :ensure  => 'directory',
      :purge   => true,
      :recurse => true,
      :force   => true,
      :owner   => 'root',
      :group   => 'bird',
      :mode    => '0640',
      :notify  => ['Service[bird]'],
    )}
    it { should contain_service('bird').with(
      :ensure => 'running',
      :enable => true,
    ) }
  end
end
