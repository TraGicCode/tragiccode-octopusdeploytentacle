require 'spec_helper'
describe 'octopusdeploytentacle::config' do
  context 'happy path' do
    instance_pregenerated_certificate_thumbprint = "190FB29BA9A26E5A3565FCCE4B2191C15032709E"
    instance_pregenerated_certificate = <<-HEREDOC
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
    HEREDOC

    let(:params) {{
      :server_url                                   => 'http://deploy.tragiccode.com',
      :api_key                                      => 'API-SDLKJFQWEIURLSMCN8348SDKJF',
      :environment                                  => 'development',
      :roles                                        => ['web-server'],
      :public_host_name                             => 'webserver.tragiccode.com',
      :server_thumbprint                            => 'CCCD736C25938806692F6C55521FA0869F29F280',
      :instance_pregenerated_certificate            => instance_pregenerated_certificate,
      :instance_pregenerated_certificate_thumbprint => instance_pregenerated_certificate_thumbprint,
    }}

    it { should contain_class('octopusdeploytentacle::params') }
    it { should contain_class('octopusdeploytentacle::config') }

    it { should contain_exec('create-octopustentacle-instance').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" create-instance --instance "Tentacle" --config "C:\\Octopus\\Tentacle\\Tentacle.config" --console"',
      :creates   => 'C:\\Octopus\\Tentacle\\Tentacle.config',
      :logoutput => 'true',
    }) }

    it { should contain_exec('create-octopustentacle-home').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" configure --instance "Tentacle" --home "C:\\Octopus" --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c "C:\\Windows\\System32\\findstr.exe "C:\\Octopus" "C:\\Octopus\\Tentacle\\Tentacle.config""',
      :logoutput => 'true',
    }).that_requires('Exec[create-octopustentacle-instance]') }

    it { should contain_exec('create-octopustentacle-app').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" configure --instance "Tentacle" --app "C:\\Applications" --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c "C:\\Windows\\System32\\findstr.exe "C:\\Applications" "C:\\Octopus\\Tentacle\\Tentacle.config""',
      :logoutput => 'true',
    }).that_requires('Exec[create-octopustentacle-home]') }

    it { should contain_exec('create-octopustentacle-port').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" configure --instance "Tentacle" --port "10933" --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c "C:\\Windows\\System32\\findstr.exe "10933" "C:\\Octopus\\Tentacle\\Tentacle.config""',
      :logoutput => 'true',
    }).that_requires('Exec[create-octopustentacle-app]') }

    it { should contain_exec('create-octopustentacle-communicationmode').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" configure --instance "Tentacle" --noListen "false" --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c "C:\\Windows\\System32\\findstr.exe "false" "C:\\Octopus\\Tentacle\\Tentacle.config""',
      :logoutput => 'true',
    }).that_requires('Exec[create-octopustentacle-port]') }

    it { should contain_exec('create-octopustentacle-trust').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" configure --instance "Tentacle" --trust "CCCD736C25938806692F6C55521FA0869F29F280" --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c "C:\\Windows\\System32\\findstr.exe "CCCD736C25938806692F6C55521FA0869F29F280" "C:\\Octopus\\Tentacle\\Tentacle.config""',
      :logoutput => 'true',
    }).that_requires('Exec[create-octopustentacle-communicationmode]') }

    it { should contain_file('C:\\pre-generated-tentacle-certificate.txt').with({
      :ensure   => 'file',
      :content  => instance_pregenerated_certificate,
    }).that_requires('Exec[create-octopustentacle-trust]') }

    it { should contain_exec('import-octopustentacle-certificate').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" import-certificate --instance "Tentacle" -f C:\\pre-generated-tentacle-certificate.txt  --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c "C:\\Windows\\System32\\findstr.exe "190FB29BA9A26E5A3565FCCE4B2191C15032709E" "C:\\Octopus\\Tentacle\\Tentacle.config""',
      :logoutput => 'true',
    }).that_requires('File[C:\\pre-generated-tentacle-certificate.txt]') }

    it { should contain_exec('install-tentacle-service').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" service --instance "Tentacle" --install --console"',
      :unless    => 'C:\\Windows\\System32\\cmd.exe /c reg query "HKLM\\SYSTEM\\CurrentControlSet\\Services\\OctopusDeploy Tentacle"',
      :logoutput => 'true',
    }).that_requires('Exec[import-octopustentacle-certificate]') }

    it { should contain_exec('register-octopustentacle-with-octopus-server').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" register-with --instance "Tentacle" --server "http://deploy.tragiccode.com" --apiKey "API-SDLKJFQWEIURLSMCN8348SDKJF" --environment "development" --role web-server --console"',
      :unless    => '$ErrorActionPreference = "Stop"
                  $result = Invoke-RestMethod -Method Get -Uri \'http://deploy.tragiccode.com/api/Machines/all?thumbprint=190FB29BA9A26E5A3565FCCE4B2191C15032709E\' -Headers @{"X-Octopus-ApiKey"="API-SDLKJFQWEIURLSMCN8348SDKJF"}
                   if ($result.Count -eq 1) {
                      Exit 0
                    }
                   Exit 1',
      :logoutput => 'true',
    }) }
  end
  describe 'octopusdeploytentacle::config' do
  context 'with roles => [web-server, database-server]' do
    instance_pregenerated_certificate_thumbprint = "190FB29BA9A26E5A3565FCCE4B2191C15032709E"
    instance_pregenerated_certificate = <<-HEREDOC
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
    HEREDOC

    let(:params) {{
      :server_url                                   => 'http://deploy.tragiccode.com',
      :api_key                                      => 'API-SDLKJFQWEIURLSMCN8348SDKJF',
      :environment                                  => 'development',
      :roles                                        => ['web-server', 'database-server'],
      :public_host_name                             => 'webserver.tragiccode.com',
      :server_thumbprint                            => 'CCCD736C25938806692F6C55521FA0869F29F280',
      :instance_pregenerated_certificate            => instance_pregenerated_certificate,
      :instance_pregenerated_certificate_thumbprint => instance_pregenerated_certificate_thumbprint,
    }}

    it { should contain_exec('register-octopustentacle-with-octopus-server').with({
      :command   => 'C:\\Windows\\System32\\cmd.exe /c ""C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe" register-with --instance "Tentacle" --server "http://deploy.tragiccode.com" --apiKey "API-SDLKJFQWEIURLSMCN8348SDKJF" --environment "development" --role web-server --role database-server --console"',
    }) }
  end
  end
end
