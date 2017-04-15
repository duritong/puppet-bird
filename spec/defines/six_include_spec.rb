require 'spec_helper'
describe 'bird::six::include', :type => 'define' do
  let(:title){'01-test'}
  let(:facts) {
    {
      :ipaddress => '1.2.3.4',
    }
  }
  context 'with a content' do
    let(:params){
      {
        :content => 'some content',
      }
    }
    it { should contain_class('bird::six') }
    it { should compile.with_all_deps }
    it { should contain_file('/etc/bird6.d/01-test.conf').with(
      :owner   => 'root',
      :group   => 'bird6',
      :mode    => '0640',
      :notify  => 'Service[bird6]',
    )}
    it { should contain_file('/etc/bird6.d/01-test.conf').with_content(/^some content$/)}
  end

  context 'with a source' do
    let(:params){
      {
        :source => 'puppet:///my_bird/test.conf',
      }
    }
    it { should contain_class('bird::six') }
    it { should compile.with_all_deps }
    it { should contain_file('/etc/bird6.d/01-test.conf').with(
      :source  => 'puppet:///my_bird/test.conf',
      :owner   => 'root',
      :group   => 'bird6',
      :mode    => '0640',
      :notify  => 'Service[bird6]',
    )}
  end

  context 'without a content nor source' do
    it { is_expected.to compile.and_raise_error(/Requires either content or source!/) }
  end
end
