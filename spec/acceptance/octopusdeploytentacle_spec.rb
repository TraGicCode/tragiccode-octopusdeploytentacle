require 'spec_helper_acceptance'

describe 'octopusdeployserver' do

  before(:all) do
    @instance = 'instance1'
  end

  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) {
      <<-MANIFEST
          class { 'octopusdeploytentacle':
            package_ensure => 'present',
          }
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(install_manifest, :catch_changes => true)
    end

    describe package('Octopus Deploy Tentacle') do
      it { should be_installed }
    end

    describe file('C:\OctopusTentacle64.msi') do
       it { should exist }
    end

    describe command("& 'C:/Program Files/Octopus Deploy/Tentacle/tentacle.exe' list-instances --console") do
      its(:stdout) { should match /Tentacle/ }
    end

    describe command("Get-Content -Path \"C:/Octopus/Tentacle/Tentacle.config\"") do
       its(:stdout) { should match /C:\\Octopus/ }
    end

  end

  # context 'when uninstalling with provided mandatory parameters' do
  #   let(:uninstall_manifest) {
  #     <<-MANIFEST
  #         class { 'octopusdeploytentacle':
  #           package_ensure => 'absent',
  #         }
  #       MANIFEST
  #   }
  #
  #   it 'should run without errors' do
  #     apply_manifest(uninstall_manifest, :catch_failures => true)
  #   end
  #
  #   it 'should be idempotent' do
  #     apply_manifest(uninstall_manifest, :catch_changes => true)
  #   end
  #
  #   describe package('Octopus Deploy Tentacle') do
  #     it { should_not be_installed }
  #   end
  #
  #   describe file('C:\OctopusTentacle64.msi') do
  #      it { should_not exist }
  #   end
  #
  # end
end
