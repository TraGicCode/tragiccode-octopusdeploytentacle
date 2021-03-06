require 'spec_helper_acceptance'

describe 'octopusdeployserver' do

  before(:all) do
    @server_thumbprint = 'CCCD736C25938806692F6C55521FA0869F29F280'
    @instance_pregenerated_certificate_thumbprint = "190FB29BA9A26E5A3565FCCE4B2191C15032709E"
    @instance_pregenerated_certificate = <<-HEREDOC
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
    HEREDOC
  end

  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) {
      <<-MANIFEST
          class { 'octopusdeploytentacle':
            package_ensure => 'present',
            server_thumbprint => '#{@server_thumbprint}',
            instance_pregenerated_certificate => '#{@instance_pregenerated_certificate}',
            instance_pregenerated_certificate_thumbprint => '#{@instance_pregenerated_certificate_thumbprint}',
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
       its(:stdout) { should match /C:\\Applications/ }
    end

    describe service('OctopusDeploy Tentacle') do
      it { should be_enabled }
      it { should be_installed }
      it { should be_running }
    end

  end

  context 'when uninstalling with provided mandatory parameters' do
    let(:uninstall_manifest) {
      <<-MANIFEST
          class { 'octopusdeploytentacle':
            package_ensure => 'absent',
            server_thumbprint => '#{@server_thumbprint}',
            instance_pregenerated_certificate => '#{@instance_pregenerated_certificate}',
            instance_pregenerated_certificate_thumbprint => '#{@instance_pregenerated_certificate_thumbprint}',
          }
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(uninstall_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(uninstall_manifest, :catch_changes => true)
    end

    describe package('Octopus Deploy Tentacle') do
      it { should_not be_installed }
    end

    describe file('C:\OctopusTentacle64.msi') do
       it { should_not exist }
    end

    describe service('OctopusDeploy Tentacle') do
      it { should_not be_installed }
    end

  end
end
