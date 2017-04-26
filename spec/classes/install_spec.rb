require 'spec_helper'
describe 'octopusdeploytentacle::install' do
  context 'with default values for all parameters' do
    it { should contain_class('octopusdeploytentacle::install') }
    it { should contain_class('octopusdeploytentacle::params') }

    it { should contain_file('C:\\OctopusTentacle64.msi').with({
      :ensure => 'file',
      :source => 'http://octopusdeploy.com/downloads/latest/OctopusTentacle64',
      }) }

      it { should contain_package('Octopus Deploy Tentacle').with({
        :ensure => 'present',
        :source => 'C:\\OctopusTentacle64.msi',
        }) }
  end

  context 'with package_ensure => installed' do
    let(:params) {{
      :package_ensure => 'installed',
    }}
    it { should contain_file('C:\\OctopusTentacle64.msi').with({
      :ensure => 'file',
      :source => 'http://octopusdeploy.com/downloads/latest/OctopusTentacle64',
      }) }
    it { should contain_package('Octopus Deploy Tentacle').with({
      :ensure => 'installed',
      :source => 'C:\\OctopusTentacle64.msi',
      }) }
  end

  context 'with package_ensure => absent' do
    let(:params) {{
      :package_ensure => 'absent',
    }}
    it { should contain_file('C:\\OctopusTentacle64.msi').with({
      :ensure => 'absent',
      :source => 'http://octopusdeploy.com/downloads/latest/OctopusTentacle64',
      }) }

    it { should contain_package('Octopus Deploy Tentacle').with({
      :ensure => 'absent',
      :source => 'C:\\OctopusTentacle64.msi',
      }) }
  end
end
